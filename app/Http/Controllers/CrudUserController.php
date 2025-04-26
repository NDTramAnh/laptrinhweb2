<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;








class CrudUserController extends Controller
{
    // 1. Hiển thị trang đăng nhập
    public function login()
    {
        return view('crud_user.login');
    }

    // 2. Xử lý đăng nhập người dùng
    public function authUser(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (Auth::attempt($request->only('email', 'password'))) {
            return redirect()->route('user.list')->with('success', 'Đăng nhập thành công!');
        }
        return back()->withErrors(['email' => 'Email hoặc mật khẩu không đúng']);
    }



    
    // 3. Hiển thị trang đăng ký
    public function createUser()
    {
        return view('crud_user.create');
    }

    // 4. Xử lý đăng ký người dùng
    public function postUser(Request $request)
    {
        $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return redirect()->route('login')->with('success', 'Đăng ký thành công! Hãy đăng nhập.');
    }

    // 5. Hiển thị thông tin chi tiết người dùng
    public function readUser($id)
    {
        $user = User::findOrFail($id);
        return view('crud_user.read', compact('user'));
    }

    // 6. Xóa người dùng
    public function deleteUser($id)
    {
        $user = User::findOrFail($id);
        $user->delete();
        return redirect()->route('user.list')->with('success', 'Xóa người dùng thành công!');
    }

    // 7. Hiển thị form chỉnh sửa người dùng
    public function updateUser($id)
    {
        $user = User::findOrFail($id);
        return view('crud_user.update', compact('user'));
    }

    // 8. Xử lý cập nhật thông tin người dùng
    public function postUpdateUser(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users,email,' . $id,
        ]);

        $user = User::findOrFail($id);
        $user->update([
            'name' => $request->name,
            'email' => $request->email,
        ]);

        return redirect()->route('users.list')->with('success', 'Cập nhật thành công!');
    }

    // 9. Hiển thị danh sách người dùng
    const MAX_RECORDS = 10;
    public function listUser()
    {
        if(Auth::check()) {
            $users = User::with(['role', 'orders'])->paginate(self::MAX_RECORDS);  // <-- Thêm with()
            return view('crud_user.list', ['users' => $users]);
        }
    
        return redirect("login")->withSuccess('You are not allowed to access');
    }

    // 10. Đăng xuất người dùng
    public function signOut()
    {
        Auth::logout();
        return redirect()->route('login')->with('success', 'Đã đăng xuất!');
    }
    
    public function showOrders(User $user)
    {
        $user->load('orders.orderDetails.product'); // load cả chi tiết đơn và sản phẩm
        return view('order.order', compact('user'));
    }
}