<template>
  <div class="space-y-6">
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div>
        <h2 class="text-2xl font-bold text-gray-900">Expense History</h2>
        <p class="text-sm text-gray-500">Tracking all stock purchase records</p>
      </div>

      <div class="bg-amber-50 border border-amber-100 p-4 rounded-2xl flex items-center gap-4">
        <div
          class="w-10 h-10 bg-amber-500 rounded-full flex items-center justify-center text-white text-lg"
        >
          💰
        </div>
        <div>
          <p class="text-xs text-amber-700 font-semibold uppercase">Total Investment</p>
          <p class="text-xl font-bold text-amber-900">${{ totalExpense.toLocaleString() }}</p>
        </div>
      </div>
    </div>

    <div class="bg-white border border-gray-100 rounded-2xl shadow-sm overflow-hidden">
      <table class="w-full text-left border-collapse">
        <thead>
          <tr class="bg-gray-50/50 border-b border-gray-100">
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Buy Date</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Product Item</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500 text-center">Qty</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Unit Price</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Total Payment</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
          <tr
            v-for="expense in expenses"
            :key="expense.id"
            class="hover:bg-gray-50/30 transition-colors"
          >
            <td class="px-6 py-4 text-sm text-gray-600 font-medium">
              {{ new Date(expense.buy_date).toLocaleDateString() }}
            </td>

            <td class="px-6 py-4">
              <div class="font-semibold text-gray-900">{{ expense.product?.name }}</div>
              <div class="text-xs text-gray-400">Purchased by User #{{ expense.user_id }}</div>
            </td>

            <td class="px-6 py-4 text-center">
              <span class="px-3 py-1 bg-slate-100 text-slate-700 rounded-lg font-mono text-sm">
                {{ expense.quantity }}
              </span>
            </td>

            <td class="px-6 py-4 text-sm text-gray-600">${{ expense.unit_price }}</td>

            <td class="px-6 py-4">
              <span class="text-base font-bold text-gray-900"> ${{ expense.total_payment }} </span>
            </td>
          </tr>

          <tr v-if="expenses.length === 0 && !loading">
            <td colspan="5" class="px-6 py-12 text-center text-gray-400 italic">
              No purchase history found.
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import api from '@/api/axios'

const expenses = ref([])
const loading = ref(true)

const fetchExpenses = async () => {
  try {
    const response = await api({
      method: 'get',
      url: '/expense-histories',
    })
    expenses.value = response.data.data.data
  } catch (error) {
    console.error('Error fetching expenses:', error)
  } finally {
    loading.value = false
  }
}

// Computed property to calculate total spending
const totalExpense = computed(() => {
  return expenses.value.reduce((acc, curr) => acc + Number(curr.total_payment), 0)
})

onMounted(fetchExpenses)
</script>
