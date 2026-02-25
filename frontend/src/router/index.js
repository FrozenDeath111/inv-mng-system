import MasterLayout from '@/layout/MasterLayout.vue'
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    redirect: '/dashboard',
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('../views/Dashboard.vue'),
    meta: { layout: MasterLayout, title: 'Dashboard', requireAuth: true },
  },
  {
    path: '/products',
    name: 'Products',
    component: () => import('../views/Product/List.vue'),
    meta: { layout: MasterLayout, title: 'Product', requireAuth: true },
  },
  {
    path: '/products/create',
    name: 'ProductCreate',
    component: () => import('../views/Product/Create.vue'),
    meta: { layout: MasterLayout, title: 'Product', requireAuth: true },
  },
  {
    path: '/expenses',
    name: 'Expenses',
    component: () => import('../views/Expense/List.vue'),
    meta: { layout: MasterLayout, title: 'Expense', requireAuth: true },
  },
  {
    path: '/stocks',
    name: 'Stocks',
    component: () => import('../views/Stock/List.vue'),
    meta: { layout: MasterLayout, title: 'Stock', requireAuth: true },
  },
  {
    path: '/sales',
    name: 'Sales',
    component: () => import('../views/Sale/List.vue'),
    meta: { layout: MasterLayout, title: 'Sale', requireAuth: true },
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

router.beforeEach((to, from) => {
  const isAuthenticated = localStorage.getItem('authenticate') === 'true'
  const token = localStorage.getItem('token')

  if (to.meta.requireAuth && (!isAuthenticated || !token)) {
    return { name: 'Login' }
  } else {
    return true
  }
})

export default router
