<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100 p-4">
    <div class="max-w-md w-full bg-white rounded-2xl shadow-xl p-8">
      <h2 class="text-3xl font-bold text-center text-gray-800 mb-8">Welcome Back</h2>
      <form @submit.prevent="handleLogin" class="space-y-6">
        <div>
          <label class="block text-sm font-medium text-gray-700">Email</label>
          <input
            type="email"
            v-model="form.email"
            class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:outline-none transition-all"
            placeholder="name@company.com"
            required
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">Password</label>
          <input
            type="password"
            v-model="form.password"
            class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:outline-none transition-all"
            placeholder="••••••••"
            required
          />
        </div>
        <button
          type="submit"
          class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-3 rounded-xl transition-all transform active:scale-[0.98]"
        >
          Sign In
        </button>
      </form>
    </div>
  </div>
</template>

<script setup>
import api from '@/api/axios'
import { useUserStore } from '@/stores/userStore'
import { reactive } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const userStore = useUserStore()

const form = reactive({
  email: '',
  password: '',
})

const handleLogin = async () => {
  try {
    const response = await api({
      method: 'POST',
      url: '/login',
      data: form,
    })

    const data = response.data.data
    userStore.loginSuccess(data)

    router.push({ name: 'Dashboard' })
  } catch (error) {
    console.log(error)
  }
}
</script>
