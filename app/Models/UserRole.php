<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class UserRole extends Model
{
    //
    protected $table = 'role_user';


    public $incrementing = true;

    protected $fillable = [
        'user_id',
        'role_id',
    ];
}
