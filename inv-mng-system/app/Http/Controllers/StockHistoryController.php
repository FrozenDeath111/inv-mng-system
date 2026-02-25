<?php

namespace App\Http\Controllers;

use App\Models\StockHistory;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class StockHistoryController extends ResponseController
{
    protected $relations = array('product:id,name');
    protected function getModel()
    {
        return new StockHistory();
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
        $query = $query->when(($request->has('product_id') && !empty($request->product_id)), function ($qr) use ($request) {
            $qr->where('product_id', $request->product_id);
        })
            ->when(($request->has('status') && !empty($request->status)), function ($qr) use ($request) {
                $qr->where('status', $request->status);
            })
            ->when(($request->has('date_range') && !empty($request->date_range)), function ($qr) use ($request) {
                $dates = explode(',', $request->date_range);

                $startDate = Carbon::parse(trim($dates[0], '"'))->startOfDay();
                $endDate = Carbon::parse(trim($dates[1], '"'))->endOfDay();

                $qr->whereBetween('update_date', [$startDate, $endDate]);
            })
            ->when(($request->has('_sort') && !empty($request->_sort)), function ($qr) use ($request) {
                ($request->has('_sort_type') && !empty($request->_sort_type)) ?
                    $qr->orderBy($request->_sort, $request->_sort_type) :
                    $qr->orderBy($request->_sort);
            });

        return $query->where('user_id', Auth::id());
    }
}
