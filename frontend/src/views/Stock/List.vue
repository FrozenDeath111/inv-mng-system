<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <h2 class="text-2xl font-bold text-gray-900">Stock Movement Log</h2>
      <button @click="fetchStockHistory" class="text-sm text-indigo-600 hover:underline">
        🔄 Refresh Log
      </button>
    </div>

    <div class="bg-white border border-gray-100 rounded-2xl shadow-sm overflow-hidden">
      <table class="w-full text-left border-collapse">
        <thead>
          <tr class="bg-gray-50/50 border-b border-gray-100">
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Date & Time</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Product</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Quantity</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Status</th>
            <th class="px-6 py-4 text-xs font-semibold uppercase text-gray-500">Updated By</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
          <tr v-for="log in history" :key="log.id" class="hover:bg-gray-50/50 transition-colors">
            <td class="px-6 py-4 text-sm text-gray-600">
              {{ formatDate(log.update_date) }}
            </td>

            <td class="px-6 py-4">
              <div class="font-medium text-gray-900">
                {{ log.product?.name || 'Unknown Product' }}
              </div>
              <div class="text-xs text-gray-400">SKU: {{ log.product_id }}</div>
            </td>

            <td
              class="px-6 py-4 font-mono font-semibold"
              :class="log.status === 'added' ? 'text-green-600' : 'text-red-600'"
            >
              {{ log.status === 'added' ? '+' : '-' }}{{ log.stock_quantity }}
            </td>

            <td class="px-6 py-4">
              <span
                :class="[
                  'px-2.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider',
                  log.status === 'added'
                    ? 'bg-green-100 text-green-700'
                    : 'bg-red-100 text-red-700',
                ]"
              >
                {{ log.status }}
              </span>
            </td>

            <td class="px-6 py-4 text-sm text-gray-500">
              <div class="flex items-center gap-2">
                <div
                  class="w-6 h-6 rounded-full bg-gray-200 flex items-center justify-center text-[10px]"
                >
                  {{ log.user_id }}
                </div>
                <span>{{ log.user?.name || 'System' }}</span>
              </div>
            </td>
          </tr>

          <tr v-if="history.length === 0 && !loading">
            <td colspan="5" class="px-6 py-12 text-center text-gray-400">
              No stock movements recorded yet.
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/api/axios'

const history = ref([])
const loading = ref(true)

const fetchStockHistory = async () => {
  try {
    const response = await api({
      method: 'get',
      url: '/stock-histories', // Ensure your Laravel route matches this
    })
    history.value = response.data.data.data
  } catch (error) {
    console.error('Error fetching history:', error)
  } finally {
    loading.value = false
  }
}

// Helper to format dates nicely
const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}

onMounted(fetchStockHistory)
</script>
