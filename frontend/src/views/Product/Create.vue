<template>
  <div class="max-w-4xl mx-auto">
    <div class="mb-6">
      <router-link
        to="/products"
        class="text-sm text-gray-500 hover:text-indigo-600 flex items-center gap-1"
      >
        ← Back to List
      </router-link>
      <h2 class="text-2xl font-bold text-gray-900 mt-2">Create New Product</h2>
    </div>

    <form @submit.prevent="handleCreateProduct" class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div
        class="md:col-span-2 space-y-6 bg-white p-8 rounded-2xl border border-gray-100 shadow-sm"
      >
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">Product Name</label>
          <input
            v-model="form.name"
            type="text"
            placeholder="e.g. Wireless Mouse"
            class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
            :class="{ 'border-red-400': errors.name }"
          />
          <p v-if="errors.name" class="mt-1 text-xs text-red-500">{{ errors.name[0] }}</p>
        </div>

        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">Category</label>
          <input
            v-model="form.category"
            type="text"
            placeholder="e.g. Electronics"
            class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
          />
        </div>

        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Buy Price</label>
            <div class="relative">
              <span class="absolute left-4 top-3 text-gray-400">$</span>
              <input
                v-model.number="form.buy_price"
                type="number"
                step="0.01"
                class="w-full pl-8 pr-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
              />
            </div>
          </div>
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Sell Price</label>
            <div class="relative">
              <span class="absolute left-4 top-3 text-gray-400">$</span>
              <input
                v-model.number="form.sell_price"
                type="number"
                step="0.01"
                class="w-full pl-8 pr-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
              />
            </div>
          </div>
        </div>
      </div>

      <div class="space-y-6">
        <div class="bg-indigo-50 p-6 rounded-2xl border border-indigo-100">
          <label class="block text-sm font-bold text-indigo-900 mb-1">Initial Stock</label>
          <p class="text-xs text-indigo-700 mb-4">
            This will automatically create a linked inventory record.
          </p>
          <input
            v-model.number="form.stock"
            type="number"
            class="w-full px-4 py-3 rounded-xl border border-indigo-200 bg-white focus:ring-2 focus:ring-indigo-500 outline-none transition-all font-mono text-lg"
          />
        </div>

        <button
          :disabled="loading"
          type="submit"
          class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-2xl shadow-lg shadow-indigo-200 transition-all transform active:scale-95 disabled:opacity-50"
        >
          <span v-if="loading">Processing...</span>
          <span v-else>Save Product</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/api/axios'

const router = useRouter()
const loading = ref(false)
const errors = ref({})

const form = reactive({
  name: '',
  category: '',
  buy_price: null,
  sell_price: null,
  stock: 0,
})

const handleCreateProduct = async () => {
  loading.value = true
  errors.value = {}

  try {
    await api({
      method: 'post',
      url: '/products',
      data: form,
    })

    // Redirect back to list on success
    router.push('/products')
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
