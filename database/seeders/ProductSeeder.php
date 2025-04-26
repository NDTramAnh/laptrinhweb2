<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i <= 30; $i++) {
            DB::table('products')->insert([
                'name' => 'Product' . $i,
                'image' => 'product' . $i . '.jpg',
                'price' => rand(10000, 500000), // Random giá
                'quantity' => rand(1, 100),     // Random tồn kho
                'description' => 'Mô tả sản phẩm ' . $i,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
