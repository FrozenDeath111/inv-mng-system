<template>
  <div class="flex h-screen bg-gray-50 text-gray-900">
    <aside class="w-64 bg-white border-r border-gray-200 flex flex-col">
      <div class="p-6 text-2xl font-bold text-indigo-600 tracking-tight">Inv-Mng-System</div>

      <nav class="flex-1 px-4 space-y-1">
        <router-link
          v-for="item in menu"
          :key="item.name"
          :to="item.path"
          class="flex items-center px-4 py-3 text-sm text-gray-600 hover:bg-gray-100 font-medium rounded-lg transition-colors"
          active-class="bg-indigo-50 text-indigo-700"
        >
          <span class="mr-3">{{ item.icon }}</span>
          {{ item.name }}
        </router-link>
      </nav>

      <div class="p-4 border-t border-gray-100">
        <button
          @click="logout"
          class="w-full flex items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50 rounded-lg"
        >
          <span class="mr-3">🚪</span> Logout
        </button>
      </div>
    </aside>

    <main class="flex-1 overflow-y-auto p-8">
      <header class="mb-8">
        <h1 class="text-2xl font-semibold">{{ $route.name }}</h1>
      </header>
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { useUserStore } from '@/stores/userStore'
import { useRouter } from 'vue-router'

const router = useRouter()
const userStore = useUserStore()

const menu = [
  { name: 'Dashboard', path: '/dashboard', icon: '📊' },
  { name: 'Products', path: '/products', icon: '📦' },
  { name: 'Stock', path: '/stocks', icon: '📈' },
  { name: 'Expenses', path: '/expenses', icon: '💸' },
  { name: 'Sales', path: '/sales', icon: '🛒' },
]

const logout = () => {
  userStore.logout()
  router.push({ name: 'Login' })
}
</script>
