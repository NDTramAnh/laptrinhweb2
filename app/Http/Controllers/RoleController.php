<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Auth;

class RoleController extends Controller
{
    //
    public function role(Request $request) {
        $role_id = $request->get('id');
        $role = Role::find($role_id);

       $data = [
           'role' => $role,
           'users' => $role->users
       ];

        return view('role.view', $data);
    }
}
