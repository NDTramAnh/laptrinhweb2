<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class RoleSeeder extends Seeder
{
    public function run(): void
    {
            DB::table('role')->insert([
                [
                    'name' => 'admin',
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
            ]);

        DB::table('role')->insert([
            [
                'name' => 'manager',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
        DB::table('role')->insert([
            [
                'name' => 'leader',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
        DB::table('role')->insert([
            [
                'name' => 'member',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

    }
}
