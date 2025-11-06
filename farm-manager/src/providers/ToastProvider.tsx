import React, { createContext, useCallback, useContext, useMemo, useState } from 'react'

type Toast = {
  id: string
  title?: string
  description?: string
  type?: 'info' | 'success' | 'error' | 'warning'
}

type ToastContextValue = {
  toasts: Toast[]
  addToast: (t: Omit<Toast, 'id'>) => string
  removeToast: (id: string) => void
}

const ToastContext = createContext<ToastContextValue | undefined>(undefined)

export function ToastProvider({ children }: { children: React.ReactNode }) {
  const [toasts, setToasts] = useState<Toast[]>([])

  const addToast = useCallback((t: Omit<Toast, 'id'>) => {
    const id = String(Date.now()) + Math.random().toString(36).slice(2, 8)
    const toast: Toast = { id, ...t }
    setToasts((s) => [toast, ...s])
    // auto-remove after 5s
    setTimeout(() => setToasts((s) => s.filter((x) => x.id !== id)), 5000)
    return id
  }, [])

  const removeToast = useCallback((id: string) => setToasts((s) => s.filter((t) => t.id !== id)), [])

  const value = useMemo(() => ({ toasts, addToast, removeToast }), [toasts, addToast, removeToast])

  return (
    <ToastContext.Provider value={value}>
      {children}
      <div aria-live="polite" className="fixed right-4 bottom-4 z-50 flex flex-col gap-2">
        {toasts.map((t) => (
          <div key={t.id} role="status" className="max-w-sm rounded shadow bg-white dark:bg-slate-800 border p-3">
            <div className="font-medium">{t.title}</div>
            {t.description ? <div className="text-sm text-slate-600 dark:text-slate-300">{t.description}</div> : null}
          </div>
        ))}
      </div>
    </ToastContext.Provider>
  )
}

export function useToast() {
  const ctx = useContext(ToastContext)
  if (!ctx) throw new Error('useToast must be used within ToastProvider')
  return ctx
}


