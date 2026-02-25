<?php

namespace App\Http\Controllers;

use App\Models\ExpenseHistory;
use App\Models\Inventory;
use App\Models\Product;
use App\Models\StockHistory;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ProductController extends ResponseController
{
    protected $relations = array('inventory');
    protected function getModel()
    {
        return new Product();
    }

    public function index(Request $request)
    {
        $pageNumber = $request->input('page', 1);
        $pageSize = $request->input('page_size', 10);

        $query = $this->applyFilters($this->getModel()->query(), $request);
        if (count($this->relations) > 0) {
            $query = $query->with($this->relations);
        }

        $data = $query->select('*')->paginate($pageSize, ['*'], 'page', $pageNumber);
        return $this->setData($data)->sendResponse('Data retrieved successfully');
    }

    protected function applyFilters($query, Request $request)
    {
        $query = $query->when(($request->has('name') && !empty($request->name)), function ($qr) use ($request) {
            $qr->where('name', 'LIKE', '%' . $request->name . '%');
        })
            ->when(($request->has('stock_range') && !empty($request->stock_range)), function ($qr) use ($request) {
                $qr->whereHas('inventory', function ($q) use ($request) {
                    $q->whereBetween('available_stock', explode(',', $request->stock_range));
                });
            })
            ->when(($request->has('buy_prices') && !empty($request->buy_prices)), function ($qr) use ($request) {
                $qr->whereBetween('buy_price', explode(',', $request->buy_prices));
            })
            ->when(($request->has('sell_prices') && !empty($request->sell_prices)), function ($qr) use ($request) {
                $qr->whereBetween('sell_price', explode(',', $request->sell_prices));
            })
            ->when(($request->has('_sort') && !empty($request->_sort)), function ($qr) use ($request) {
                ($request->has('_sort_type') && !empty($request->_sort_type)) ?
                    $qr->orderBy($request->_sort, $request->_sort_type) :
                    $qr->orderBy($request->_sort);
            });

        return $query->where('user_id', Auth::id());
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'category' => 'required',
            'buy_price' => 'required|min:0',
            'sell_price' => 'required|min:0',
            'stock' => 'required|min:0'
        ]);

        if ($validator->fails()) {
            return $this->setStatusCode(422)->setData($validator->errors())->sendError('Validation Error');
        }

        $input = $request->all();

        try {
            DB::transaction(function () use ($input) {
                $inventory = Inventory::create([
                    'available_stock' => $input['stock'],
                    'total_stock' => $input['stock'],
                    'total_sold' => 0,
                ]);

                $product = $this->getModel()::create([
                    'name' => $input['name'],
                    'user_id' => Auth::id(),
                    'category' => $input['category'],
                    'buy_price' => $input['buy_price'],
                    'sell_price' => $input['sell_price'],
                    'inventory_id' => $inventory->id
                ]);

                StockHistory::create([
                    'update_date' => Carbon::now(),
                    'stock_quantity' => $input['stock'],
                    'product_id' => $product->id,
                    'user_id' => Auth::id(),
                    'status' => 'added'
                ]);

                $totalPayment = $input['stock'] * $input['buy_price'];
                ExpenseHistory::create([
                    'buy_date' => Carbon::now(),
                    'product_id' => $product->id,
                    'user_id' => Auth::id(),
                    'unit_price' => $input['buy_price'],
                    'quantity' => $input['stock'],
                    'total_payment' => $totalPayment,
                ]);
            });

            return $this->sendResponse('Product Creation Successfully');
        } catch (\Throwable $th) {
            return $this->setStatusCode(400)->sendError($th->getMessage());
        }
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'category' => 'required',
            'buy_price' => 'required|min:0',
            'sell_price' => 'required|min:0',
        ]);

        if ($validator->fails()) {
            return $this->setStatusCode(422)->setData($validator->errors())->sendError('Validation Error');
        }

        $product = $this->getModel()::find($id);
        if (!$product) {
            return $this->setStatusCode(404)->sendError("Product Not Found");
        }

        $input = $request->all();
        $input['user_id'] = Auth::id();

        $product->update($input);
        if ($product) {
            return $this->setStatusCode(201)->sendResponse('Updated successfully');
        } else {
            return $this->sendError();
        }
    }

    public function show($id)
    {
        $product = $this->getModel()::where(['id' => $id, 'user_id' => Auth::id()])->when(count($this->relations) > 0, function ($q) {
            $q->with($this->relations);
        })->first();

        if (!$product) {
            return $this->setStatusCode(404)->sendError("Data Not Found");
        }

        return $this->setStatusCode(201)->setData($product)->sendResponse('Fetch Successfull');
    }

    public function addInventory(Request $request, $productId)
    {
        $validator = Validator::make($request->all(), [
            'added_stock' => 'required|min:0',
        ]);

        if ($validator->fails()) {
            return $this->setStatusCode(422)->setData($validator->errors())->sendError('Validation Error');
        }

        $product = $this->getModel()::find($productId);
        if (!$product) {
            return $this->setStatusCode(404)->sendError("Data Not Found");
        }

        $input = $request->all();

        try {
            DB::transaction(function () use ($input, $product) {
                $inventory = Inventory::find($product->inventory->id);
                $inventory->available_stock += $input['added_stock'];
                $inventory->total_stock += $input['added_stock'];
                $inventory->save();

                StockHistory::create([
                    'update_date' => Carbon::now(),
                    'stock_quantity' => $input['added_stock'],
                    'product_id' => $product->id,
                    'user_id' => Auth::id(),
                    'status' => 'added'
                ]);

                $totalPayment = $input['added_stock'] * $product->buy_price;
                ExpenseHistory::create([
                    'buy_date' => Carbon::now(),
                    'product_id' => $product->id,
                    'user_id' => Auth::id(),
                    'unit_price' => $product->buy_price,
                    'quantity' => $input['added_stock'],
                    'total_payment' => $totalPayment,
                ]);
            });
            return $this->sendResponse('Inventory Added Successfully');
        } catch (\Throwable $th) {
            return $this->setStatusCode(400)->sendError($th->getMessage());
        }
    }
}
