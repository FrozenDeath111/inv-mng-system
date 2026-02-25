<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use App\Models\Product;
use App\Models\Sale;
use App\Models\StockHistory;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class SalesController extends ResponseController
{
    protected $relations = array('product:id,name');
    protected function getModel()
    {
        return new Sale();
    }

    public function index(Request $request)
    {
        $pageNumber = $request->input('page', 1);
        $pageSize = $request->input('page_size', 10);

        if (!$request->has('_sort') && !$request->has('_sort_type')) {
            $request['_sort'] = 'desc';
            $request['_sort_type'] = 'created_at';
        }

        $query = $this->applyFilters($this->getModel()->query(), $request);
        if (count($this->relations) > 0) {
            $query = $query->with($this->relations);
        }

        // $data = $query->select('*')->paginate($pageSize, ['*'], 'page', $pageNumber);
        // return $this->setData($data)->sendResponse('Data retrieved successfully');

        $data = $query->select('*')->get();
        return $this->setData(['data' => $data])->sendResponse('Data retrieved successfully');
    }

    protected function applyFilters($query, Request $request)
    {
        $query = $query->when(($request->has('customer_name') && !empty($request->customer_name)), function ($qr) use ($request) {
            $qr->where('customer_name', 'LIKE', '%' . $request->customer_name . '%');
        })
            ->when(($request->has('product_id') && !empty($request->product_id)), function ($qr) use ($request) {
                $qr->where('product_id', $request->product_id);
            })
            ->when(($request->has('due') && !empty($request->due)), function ($qr) use ($request) {
                $qr->where('due_amount', '>=', $request->due);
            })
            ->when(($request->has('date_range') && !empty($request->date_range)), function ($qr) use ($request) {
                $dates = explode(',', $request->date_range);

                $startDate = Carbon::parse(trim($dates[0], '"'))->startOfDay();
                $endDate = Carbon::parse(trim($dates[1], '"'))->endOfDay();

                $qr->whereBetween('payment_date', [$startDate, $endDate]);
            })
            ->when(($request->has('_sort') && !empty($request->_sort)), function ($qr) use ($request) {
                ($request->has('_sort_type') && !empty($request->_sort_type)) ?
                    $qr->orderBy($request->_sort_type, $request->_sort) :
                    $qr->orderBy($request->_sort);
            });

        return $query->where('user_id', Auth::id());
    }

    public function initiateSale(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'product_id' => 'required',
            'customer_name' => 'required',
            'quantity' => 'required|min:0',
            'discount_amount' => 'required|min:0',
            'vat_amount' => 'required|min:0',
            'customer_paid_amount' => 'required|min:0',
            'payment_date' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->setStatusCode(422)->setData($validator->errors())->sendError('Validation Error');
        }

        $product = Product::find($request->product_id);
        if (!$product) {
            return $this->setStatusCode(404)->sendError("Product Not Found");
        }

        $inventory = Inventory::find($product->inventory->id);
        if ($inventory->available_stock < $request->quantity) {
            return $this->setStatusCode(400)->sendError("Not Enough Products");
        }

        $input = $request->all();

        $input['total_price'] = $product->sell_price * $input['quantity'];
        $input['final_payment'] = $input['total_price'] + ($input['total_price'] * ($input['vat_amount'] / 100)) - $input['discount_amount'];
        $input['due_amount'] = max(0, $input['final_payment'] - $input['customer_paid_amount']);

        try {
            DB::transaction(function () use ($input, $product, $inventory) {
                $input['user_id'] = Auth::id();
                $input['payment_date'] = Carbon::parse(trim(',', $input['payment_date']));
                $this->getModel()::create($input);

                $inventory->available_stock -= $input['quantity'];
                $inventory->total_sold += $input['quantity'];
                $inventory->save();

                StockHistory::create([
                    'update_date' => Carbon::now(),
                    'stock_quantity' => $input['quantity'],
                    'product_id' => $product->id,
                    'user_id' => Auth::id(),
                    'status' => 'sold'
                ]);
            });
            return $this->sendResponse('Sale Initiated Successfully');
        } catch (\Throwable $th) {
            return $this->setStatusCode(400)->sendError($th->getMessage());
        }
    }
}
