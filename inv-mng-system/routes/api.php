<?php

use Illuminate\Support\Facades\Route;

Route::post('/register', [App\Http\Controllers\AuthController::class, 'register']);
Route::post('/login', [App\Http\Controllers\AuthController::class, 'login']);

Route::group(['middleware' => 'auth:api'], function () {
    Route::get('/profile', [App\Http\Controllers\AuthController::class, 'profile']);
    Route::get('/logout', [App\Http\Controllers\AuthController::class, 'logout']);

    Route::get('/products', [App\Http\Controllers\ProductController::class, 'index']);
    Route::get('/product/{id}', [App\Http\Controllers\ProductController::class, 'show']);
    Route::post('/products', [App\Http\Controllers\ProductController::class, 'store']);
    Route::post('/inventory/product/{productId}', [App\Http\Controllers\ProductController::class, 'addInventory']);
    Route::put('/product/{id}', [App\Http\Controllers\ProductController::class, 'update']);

    Route::get('/stock-histories', [App\Http\Controllers\StockHistoryController::class, 'index']);
    Route::get('/expense-histories', [App\Http\Controllers\ExpenseHistoryController::class, 'index']);

    Route::get('/sales', [App\Http\Controllers\SalesController::class, 'index']);
    Route::post('/sales', [App\Http\Controllers\SalesController::class, 'initiateSale']);
});