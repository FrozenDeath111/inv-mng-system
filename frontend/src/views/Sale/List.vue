<template>
  <div class="space-y-10">
    <section class="bg-white p-8 rounded-3xl border border-gray-100 shadow-sm">
      <h3 class="text-xl font-bold text-gray-900 mb-6 flex items-center gap-2">
        <span class="p-2 bg-emerald-100 rounded-lg text-emerald-600 text-sm">🛒</span>
        New Sale Entry
      </h3>

      <form @submit.prevent="submitSale" class="grid grid-cols-1 md:grid-cols-4 gap-5">
        <div class="md:col-span-2">
          <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Product</label>
          <select
            v-model="form.product_id"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-emerald-500"
          >
            <option value="" disabled>Select a product</option>
            <option v-for="p in products" :key="p.id" :value="p.id">
              {{ p.name }} (${{ p.sell_price }})
            </option>
          </select>
        </div>

        <div>
          <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Customer Name</label>
          <input
            v-model="form.customer_name"
            type="text"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-emerald-500"
            placeholder="Walk-in Customer"
          />
        </div>

        <div>
          <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Payment Date</label>
          <input
            v-model="form.payment_date"
            type="date"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-emerald-500"
          />
        </div>

        <div>
          <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Quantity</label>
          <input
            v-model="form.quantity"
            type="number"
            min="1"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-emerald-500"
          />
        </div>

        <div>
          <label class="block text-xs font-bold uppercase mb-1 text-red-400">Discount ($)</label>
          <input
            v-model="form.discount_amount"
            type="number"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-red-400"
          />
        </div>

        <div>
          <label class="block text-xs font-bold uppercase mb-1 text-blue-400">VAT ($)</label>
          <input
            v-model="form.vat_amount"
            type="number"
            class="w-full bg-gray-50 border-none rounded-xl p-3 focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div class="bg-emerald-50 p-3 rounded-xl border border-emerald-100">
          <label class="block text-xs font-bold text-emerald-700 uppercase mb-1"
            >Paid Amount ($)</label
          >
          <input
            v-model="form.customer_paid_amount"
            type="number"
            class="w-full bg-white border-none rounded-lg p-2 focus:ring-2 focus:ring-emerald-500"
          />
        </div>

        <div
          class="md:col-span-4 flex flex-col md:flex-row items-center justify-between pt-4 border-t border-gray-50 mt-2"
        >
          <div class="flex gap-8 mb-4 md:mb-0">
            <div>
              <p class="text-xs text-gray-400 uppercase font-bold">Total Bill</p>
              <p class="text-2xl font-black text-gray-900">${{ totalPrice }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-400 uppercase font-bold">Due Amount</p>
              <p class="text-2xl font-black text-red-500">${{ dueAmount }}</p>
            </div>
          </div>
          <button
            :disabled="loading"
            type="submit"
            class="w-full md:w-auto px-10 py-4 bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-2xl shadow-lg shadow-emerald-100 transition-all active:scale-95"
          >
            {{ loading ? 'Saving...' : 'Complete Transaction' }}
          </button>
        </div>
      </form>
    </section>

    <section class="space-y-4">
      <h3 class="text-lg font-bold text-gray-800">Recent Sales History</h3>
      <div
        class="bg-white border border-gray-100 rounded-3xl shadow-sm overflow-hidden overflow-x-auto"
      >
        <table class="w-full text-left min-w-[1000px]">
          <thead class="bg-gray-50/50">
            <tr
              class="text-[11px] uppercase tracking-widest text-gray-400 font-bold border-b border-gray-100"
            >
              <th class="px-6 py-4">Date</th>
              <th class="px-6 py-4">Product</th>
              <th class="px-6 py-4">Customer</th>
              <th class="px-6 py-4 text-center">Qty</th>
              <th class="px-6 py-4 text-right">Bill / Paid</th>
              <th class="px-6 py-4 text-right text-red-500">Due</th>
              <th class="px-6 py-4 text-center">Status</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-50">
            <tr
              v-for="sale in sales"
              :key="sale.id"
              class="text-sm text-gray-600 hover:bg-gray-50/50 transition-colors"
            >
              <td class="px-6 py-4 whitespace-nowrap">{{ sale.payment_date }}</td>
              <td class="px-6 py-4 font-bold text-gray-900">{{ sale.product?.name }}</td>
              <td class="px-6 py-4">{{ sale.customer_name }}</td>
              <td class="px-6 py-4 text-center font-mono">{{ sale.quantity }}</td>
              <td class="px-6 py-4 text-right">
                <div class="font-bold text-gray-900">${{ sale.total_price }}</div>
                <div class="text-[10px] text-emerald-500">
                  Paid: ${{ sale.customer_paid_amount }}
                </div>
              </td>
              <td class="px-6 py-4 text-right font-bold text-red-500">${{ sale.due_amount }}</td>
              <td class="px-6 py-4 text-center">
                <span
                  :class="
                    sale.final_payment
                      ? 'bg-emerald-100 text-emerald-700'
                      : 'bg-orange-100 text-orange-700'
                  "
                  class="px-2 py-1 rounded-md text-[10px] font-black uppercase"
                >
                  {{ sale.final_payment ? 'Paid' : 'Pending' }}
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </div>
</template>

<script setup>
import { reactive, ref, onMounted, computed } from 'vue'
import api from '@/api/axios'

const sales = ref([])
const products = ref([]) // To populate a dropdown for product_id
const loading = ref(false)

const form = reactive({
  product_id: '',
  customer_name: '',
  quantity: 1,
  discount_amount: 0,
  vat_amount: 0,
  customer_paid_amount: 0,
  payment_date: new Date().toISOString().split('T')[0],
})

// Real-time calculation logic
const totalPrice = computed(() => {
  const selectedProduct = products.value.find((p) => p.id === form.product_id)
  const price = selectedProduct ? selectedProduct.sell_price : 0
  return (
    price * form.quantity +
    price * form.quantity * (Number(form.vat_amount) / 100) -
    Number(form.discount_amount)
  )
})

const dueAmount = computed(() => {
  return Math.max(0, totalPrice.value - form.customer_paid_amount).toFixed(2)
})

const fetchData = async () => {
  const [salesRes, prodRes] = await Promise.all([
    api({ method: 'get', url: '/sales' }),
    api({ method: 'get', url: '/products' }),
  ])
  sales.value = salesRes.data.data.data
  products.value = prodRes.data.data.data
}

const submitSale = async () => {
  loading.value = true
  try {
    await api({ method: 'post', url: '/sales', data: form })
    form.customer_name = '' // Reset form
    form.quantity = 1
    fetchData() // Refresh list
  } catch (err) {
    alert('Check stock availability or form errors.')
  } finally {
    loading.value = false
  }
}

onMounted(fetchData)
</script>
