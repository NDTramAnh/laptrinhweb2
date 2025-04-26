<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OrderDetailSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i <= 30; $i++) {
            $numProducts = rand(1, 2); // mỗi order có 1-2 sản phẩm
            for ($j = 1; $j <= $numProducts; $j++) {
                DB::table('order_detail')->insert([
                    'order_id' => $i,
                    'product_id' => rand(1, 30),
                    'quantity' => rand(1, 5),
                    'notes' => 'Ghi chú đơn hàng ' . $i . '-' . $j,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
