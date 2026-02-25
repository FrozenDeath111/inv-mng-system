<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Inventory extends Model
{
    protected $fillable = [
        'available_stock',
        'total_sold',
        'total_stock',
    ];

    public function product(): HasOne
    {
        return $this->hasOne(Product::class);
    }
}