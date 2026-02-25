import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
  const user = ref({})

  const loginSuccess = (data) => {
    localStorage.setItem('authenticate', true)
    localStorage.setItem('token', data.token)

    user.value = data.user
  }

  const logout = () => {
    localStorage.removeItem('authenticate')
    localStorage.removeItem('token')
  }

  const getUser = () => {
    return user.value
  }

  return {
    loginSuccess,
    logout,
    getUser,
  }
})
