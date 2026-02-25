<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ExpenseHistory extends Model
{
    protected $fillable = [
        'buy_date',
        'product_id',
        'user_id',
        'unit_price',
        'quantity',
        'total_payment',
    ];

    protected $casts = [
        'buy_date' => 'datetime',
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}