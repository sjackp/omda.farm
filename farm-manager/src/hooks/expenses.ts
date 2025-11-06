import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPost } from '../lib/api'
import { useCurrentCycle } from './cycles'

export type Expense = {
  id: number
  cycle_id: number
  expense_category_id: number
  expense_date: string
  amount: string | number
  currency_code: string
  description: string | null
  created_at: string
}

export function useExpenseCategories() {
  const [data, setData] = useState<Array<{ id: number; name: string }>>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      const rows = await apiGet<Array<{ id: number; name: string }>>('/api/expense-categories')
      setData(rows || [])
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { fetcher() }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useExpenses(cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<Expense[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    if (!targetCycle) {
      setData([])
      setLoading(false)
      return
    }
    setLoading(true)
    try {
      const rows = await apiGet<Expense[]>(`/api/expenses?cycle_id=${targetCycle}`)
      setData(rows ?? [])
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [targetCycle])

  useEffect(() => { fetcher() }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useCreateExpense() {
  const { refetch } = useExpenses()

  const create = useCallback(async (payload: { cycle_id: number; expense_category_id: number; expense_date: string; amount: number; currency_code?: string; description?: string }) => {
    const body = {
      cycle_id: payload.cycle_id,
      expense_category_id: payload.expense_category_id,
      expense_date: payload.expense_date,
      amount: payload.amount,
      currency_code: payload.currency_code ?? 'EGP',
      description: payload.description ?? null,
    }
    try {
      await apiPost('/api/expenses', body)
      await refetch()
      return null
    } catch (e) {
      return e
    }
  }, [refetch])

  return { create }
}

export function useCreateExpenseCategory() {
  const create = useCallback(async (payload: { name: string; description?: string }) => {
    try {
      const data = await apiPost<{ id: number; name: string }>('/api/expense-categories', payload)
      return { error: null as any, data }
    } catch (error) {
      return { error, data: null as any }
    }
  }, [])
  return { create }
}


