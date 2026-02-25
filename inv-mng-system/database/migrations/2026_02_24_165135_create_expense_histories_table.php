<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('expense_histories', function (Blueprint $table) {
            $table->id();
            $table->dateTime('buy_date');
            $table->bigInteger('product_id');
            $table->bigInteger('user_id');
            $table->decimal('unit_price', 15, 2);
            $table->integer('quantity');
            $table->decimal('total_payment', 15, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expense_histories');
    }
};
