@extends('dashboard')

@section('content')
    <div class="container">
        <h2>Orders of {{ $user->name }}</h2>
        @forelse ($user->orders as $order)
            <div class="card mb-3">
                <div class="card-header">
                    Order #{{ $order->id }} – Total: ${{ $order->total_amount }}
                </div>
                <div class="card-body">
                    <strong>Address:</strong> {{ $order->address }}<br>
                    <strong>Products:</strong>
                    <ul>
                        @foreach ($order->orderDetails as $detail)
                            <li>
                                {{ $detail->product->name }} – {{ $detail->quantity }} pcs
                            </li>
                        @endforeach
                    </ul>
                </div>
            </div>
        @empty
            <p>No orders found for this user.</p>
        @endforelse
    </div>
@endsection