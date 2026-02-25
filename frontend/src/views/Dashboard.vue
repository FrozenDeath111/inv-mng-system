<template>
  <div class="p-6 space-y-8 bg-gray-50 min-h-screen">
    <div
      class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 p-4 bg-amber-100 rounded-lg"
    >
      <div>
        <h3 class="text-sm font-bold text-gray-400 uppercase tracking-widest">Date Range</h3>
      </div>
      <div class="flex items-center gap-2 bg-gray-50 p-1.5 rounded-xl border border-gray-100">
        <input
          v-model="dateRangeFilter.start"
          type="datetime-local"
          class="bg-transparent text-[11px] font-bold text-gray-600 outline-none px-2"
        />
        <span class="text-gray-300 text-xs">to</span>
        <input
          v-model="dateRangeFilter.end"
          type="datetime-local"
          class="bg-transparent text-[11px] font-bold text-gray-600 outline-none px-2"
        />
      </div>
    </div>
    <div
      class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 p-4 bg-amber-100 rounded-lg"
    >
      <button
        @click="handleFilter"
        class="p-4 bg-white/20 hover:bg-white/30 py-2 rounded-xl text-xs font-bold transition-all"
      >
        Filter Date
      </button>
      <button
        @click="resetFilter"
        class="p-4 bg-white/20 hover:bg-white/30 py-2 rounded-xl text-xs font-bold transition-all"
      >
        Reset Filter
      </button>
    </div>
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100">
        <h3 class="text-sm font-bold text-gray-400 uppercase tracking-widest mb-4">
          Stock Movement
        </h3>
        <div class="h-64">
          <Line :data="stocksLineData" :options="{ maintainAspectRatio: false }" v-if="!loading" />
        </div>
      </div>

      <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100">
        <h3 class="text-sm font-bold text-gray-400 uppercase tracking-widest mb-4">
          Stock Distribution
        </h3>
        <div class="h-64 flex justify-center">
          <Pie :data="inventoryPieData" v-if="!loading" />
        </div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="lg:col-span-2 bg-white p-6 rounded-3xl shadow-sm border border-gray-100">
        <h3 class="text-sm font-bold text-gray-400 uppercase tracking-widest mb-4">Sales Amount</h3>
        <div class="h-64">
          <Line :data="salesLineData" v-if="!loading" />
        </div>
      </div>

      <div class="bg-indigo-600 rounded-3xl p-8 text-white flex flex-col justify-center">
        <p class="text-indigo-200 text-xs font-bold uppercase">Total Performance</p>
        <h2 class="text-4xl font-black mt-2">${{ totalSalesValue.toLocaleString() }}</h2>
        <p class="text-indigo-100 text-sm mt-4 opacity-80">
          {{ rawSales.length }} Transactions recorded
        </p>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="lg:col-span-2 bg-white p-6 rounded-3xl shadow-sm border border-gray-100">
        <h3 class="text-sm font-bold text-gray-400 uppercase tracking-widest mb-4">
          Expense Trends
        </h3>
        <div class="h-64">
          <Line :data="expensesLineData" v-if="!loading" />
        </div>
      </div>

      <div
        class="bg-white border-2 border-dashed border-gray-200 rounded-3xl p-8 flex flex-col items-center justify-center text-center"
      >
        <div
          class="w-12 h-12 bg-amber-100 text-amber-600 rounded-full flex items-center justify-center mb-4"
        >
          💰
        </div>
        <p class="text-gray-400 text-xs font-bold uppercase">Total Investment</p>
        <h2 class="text-3xl font-black text-gray-900">${{ totalInvestment.toLocaleString() }}</h2>
        <p class="text-gray-500 text-xs mt-2">Value of all purchased stock</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import api from '@/api/axios'
import { Line, Pie } from 'vue-chartjs'
import { Chart as ChartJS, registerables } from 'chart.js'

ChartJS.register(...registerables)

const dateRange = ref('2026-01-01,2026-12-31')
const dateRangeFilter = reactive({
  start: '',
  end: '',
})
const loading = ref(true)

// Raw Data Storage
const rawSales = ref([])
const rawExpenses = ref([])
const rawStocks = ref([])
const rawProducts = ref([])

const fetchData = async () => {
  loading.value = true
  try {
    // Fetching from individual endpoints
    const [salesRes, expenseRes, stockRes, productRes] = await Promise.all([
      api.get(`/sales?date_range=${dateRange.value}`),
      api.get(`/expense-histories?date_range=${dateRange.value}`),
      api.get(`/stock-histories?date_range=${dateRange.value}`),
      api.get('/products'), // Assuming we want all product stock levels
    ])

    rawSales.value = salesRes.data.data.data
    rawExpenses.value = expenseRes.data.data.data
    rawStocks.value = stockRes.data.data.data
    rawProducts.value = productRes.data.data.data
  } catch (error) {
    console.error('Dashboard sync failed', error)
  } finally {
    loading.value = false
  }
}

const handleFilter = async () => {
  if (dateRangeFilter.start && dateRangeFilter.end) {
    const startTimestamp = new Date(dateRangeFilter.start)
    const endTimestamp = new Date(dateRangeFilter.end)

    if (endTimestamp > startTimestamp)
      dateRange.value = dateRangeFilter.start + ',' + dateRangeFilter.end
  }

  await fetchData()
}

const resetFilter = async () => {
  dateRangeFilter.start = ''
  dateRangeFilter.end = ''
  dateRange.value = ''

  await fetchData()
}

// --- DATA TRANSFORMATIONS FOR CHARTS ---

// 1. Inventory Pie Chart (Product Names vs Available Stock)
const inventoryPieData = computed(() => ({
  labels: rawProducts.value.map((p) => p.name),
  datasets: [
    {
      data: rawProducts.value.map((p) => p.inventory?.available_stock || 0),
      backgroundColor: ['#6366f1', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'],
    },
  ],
}))

// 2. Sales Line Chart (Date vs Total Price)
const salesLineData = computed(() => {
  const grouped = rawSales.value.reduce((acc, sale) => {
    const date = sale.payment_date.split('.')[0]
    acc[date] = (acc[date] || 0) + Number(sale.final_payment)
    return acc
  }, {})

  return {
    labels: Object.keys(grouped),
    datasets: [
      {
        label: 'Revenue',
        data: Object.values(grouped),
        borderColor: '#10b981',
        tension: 0.4,
        fill: true,
        backgroundColor: 'rgba(16, 185, 129, 0.1)',
      },
    ],
  }
})

const expensesLineData = computed(() => {
  const grouped = rawExpenses.value.reduce((acc, expense) => {
    const date = expense.buy_date.split('.')[0]
    acc[date] = (acc[date] || 0) + Number(expense.total_payment)
    return acc
  }, {})

  return {
    labels: Object.keys(grouped),
    datasets: [
      {
        label: 'Expense',
        data: Object.values(grouped),
        borderColor: '#10b981',
        tension: 0.4,
        fill: true,
        backgroundColor: 'rgba(16, 185, 129, 0.1)',
      },
    ],
  }
})

const stocksLineData = computed(() => {
  const grouped = rawStocks.value.reduce((acc, stock) => {
    const date = stock.update_date.split('.')[0]
    if (stock.status === 'sold') {
      stock.stock_quantity = -1 * Number(stock.stock_quantity)
    }
    acc[date] = (acc[date] || 0) + Number(stock.stock_quantity)
    return acc
  }, {})

  return {
    labels: Object.keys(grouped),
    datasets: [
      {
        label: 'Stock Amount',
        data: Object.values(grouped),
        borderColor: '#10b981',
        tension: 0.4,
        fill: true,
        backgroundColor: 'rgba(16, 185, 129, 0.1)',
      },
    ],
  }
})

// 3. Totals for Cards
const totalSalesValue = computed(() =>
  rawSales.value.reduce((sum, s) => sum + Number(s.total_price), 0),
)
const totalInvestment = computed(() =>
  rawExpenses.value.reduce((sum, e) => sum + Number(e.total_payment), 0),
)

onMounted(fetchData)
</script>
