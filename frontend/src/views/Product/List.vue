<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div class="relative w-72">
        <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">🔍</span>
        <input
          type="text"
          placeholder="Search products..."
          class="w-full pl-10 pr-4 py-2 bg-white border border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
        />
      </div>
      <router-link
        to="/products/create"
        class="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-2.5 rounded-xl font-medium transition-transform active:scale-95 shadow-sm"
      >
        + Add Product
      </router-link>
    </div>

    <div class="bg-white border border-gray-100 rounded-2xl shadow-sm overflow-hidden">
      <table class="w-full text-left border-collapse">
        <thead>
          <tr class="bg-gray-50/50 border-b border-gray-100">
            <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wider text-gray-500">
              Product
            </th>
            <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wider text-gray-500">
              Category
            </th>
            <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wider text-gray-500">
              Price
            </th>
            <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wider text-gray-500">
              Stock Status
            </th>
            <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wider text-gray-500">
              Add Stock
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
          <tr v-if="loading" v-for="i in 3" :key="i" class="animate-pulse">
            <td colspan="5" class="px-6 py-4 bg-gray-50/20 h-16"></td>
          </tr>

          <tr
            v-for="product in products"
            :key="product.id"
            class="hover:bg-gray-50/80 transition-colors"
          >
            <td class="px-6 py-4">
              <div class="font-medium text-gray-900">{{ product.name }}</div>
              <div class="text-xs text-gray-400">ID: #{{ product.id }}</div>
            </td>
            <td class="px-6 py-4 text-sm text-gray-600">
              <span class="px-2 py-1 bg-gray-100 rounded-md">{{ product.category || 'N/A' }}</span>
            </td>
            <td class="px-6 py-4">
              <div class="text-sm font-semibold text-gray-900">${{ product.sell_price }}</div>
              <div class="text-xs text-gray-400">Cost: ${{ product.buy_price }}</div>
            </td>
            <td class="px-6 py-4">
              <div class="flex items-center">
                <span
                  :class="[
                    'px-2.5 py-1 rounded-full text-xs font-bold mr-2',
                    product.inventory?.available_stock > 10
                      ? 'bg-green-100 text-green-700'
                      : product.inventory?.available_stock > 0
                        ? 'bg-yellow-100 text-yellow-700'
                        : 'bg-red-100 text-red-700',
                  ]"
                >
                  {{ product.inventory?.available_stock }} in stock
                </span>
              </div>
            </td>
            <td class="px-6 py-4 text-right space-x-3">
              <form @submit.prevent="handleAddInventory(product.id)" class="flex flex-col">
                <input
                  v-model.number="form.added_stock"
                  type="number"
                  step="0.01"
                  class="w-full p-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
                />
                <button
                  type="submit"
                  class="text-indigo-600 hover:text-indigo-900 font-medium text-sm p-2"
                >
                  Add
                </button>
              </form>
            </td>
          </tr>
        </tbody>
      </table>

      <div v-if="!loading && products.length === 0" class="p-12 text-center text-gray-500">
        No products found. Start by adding a new one!
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import api from '@/api/axios'

const products = ref([])
const loading = ref(true)

const form = reactive({
  added_stock: 0,
})

const fetchProducts = async () => {
  try {
    const response = await api({
      method: 'get',
      url: '/products',
    })
    products.value = response.data.data.data
  } catch (error) {
    console.error('Failed to load products', error)
  } finally {
    loading.value = false
  }
}

onMounted(fetchProducts)

const handleAddInventory = async (id) => {
  loading.value = true

  try {
    await api({
      method: 'post',
      url: '/inventory/product/' + id,
      data: form,
    })

    await fetchProducts()
    form.added_stock = 0
  } catch (err) {
    if (err.response?.status === 422) {
      errors.value = err.response.data.errors
    } else {
      alert('An unexpected error occurred.')
    }
  } finally {
    loading.value = false
  }
}
</script>
