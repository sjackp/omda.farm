import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import { apiPost } from '../lib/api'

export type AuthUser = {
  id: number
  username: string
}

type AuthStatus = 'loading' | 'authenticated' | 'unauthenticated'

type AuthContextValue = {
  user: AuthUser | null
  status: AuthStatus
  login: (username: string, password: string) => Promise<void>
  logout: () => void
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined)

const STORAGE_KEY = 'farm-manager-auth-user'

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null)
  const [status, setStatus] = useState<AuthStatus>('loading')

  useEffect(() => {
    try {
      const raw = localStorage.getItem(STORAGE_KEY)
      if (raw) {
        const parsed = JSON.parse(raw) as AuthUser
        if (parsed?.id && parsed?.username) {
          setUser(parsed)
          setStatus('authenticated')
          return
        }
      }
    } catch (err) {
      console.warn('Failed to hydrate auth user from storage', err)
    }
    setStatus('unauthenticated')
  }, [])

  const login = useCallback(async (username: string, password: string) => {
    const cleanedUsername = username.trim()
    if (!cleanedUsername || !password) {
      throw new Error('Username and password are required')
    }

    try {
      const response = await apiPost<{ user: AuthUser }>('/api/login', {
        username: cleanedUsername,
        password,
      })
      setUser(response.user)
      localStorage.setItem(STORAGE_KEY, JSON.stringify(response.user))
      setStatus('authenticated')
    } catch (error) {
      setStatus('unauthenticated')
      if (error instanceof Error && error.message) {
        throw error
      }
      throw new Error('Unable to sign in. Please try again.')
    }
  }, [])

  const logout = useCallback(() => {
    setUser(null)
    localStorage.removeItem(STORAGE_KEY)
    setStatus('unauthenticated')
  }, [])

  const value = useMemo<AuthContextValue>(
    () => ({ user, status, login, logout }),
    [user, status, login, logout]
  )

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return ctx
}





