<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i <= 30; $i++) {
            DB::table('orders')->insert([
                'user_id' => rand(1, 30), // Random người đặt
                'total_amount' => rand(50000, 1000000),
                'address' => 'Địa chỉ số ' . $i,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
