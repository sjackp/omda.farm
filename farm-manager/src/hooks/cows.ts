import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPatch, apiPost } from '../lib/api'
import { emitGlobalRefresh, onGlobalRefresh } from '../lib/refresh'
import { useCurrentCycle } from './cycles'

export type Cow = {
  id: number
  cycle_id: number
  external_id: string
  breed: string | null
  status: 'active' | 'sold' | 'dead'
  notes: string | null
  created_at: string
  current_group_id?: number | null
  current_group_number?: number | null
  latest_weight_kg?: number | null
  purchase_price?: number | null
  purchase_currency_code?: string
  purchase_date?: string | null
}

export function useCows(cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<Cow[]>([])
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
      const rows = await apiGet<Cow[]>(`/api/cows?cycle_id=${targetCycle}`)
      setData(rows)
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [targetCycle])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useCreateCow() {
  const create = useCallback(async (payload: { cycle_id: number; external_id: string; breed?: string; purchase_price: number; purchase_currency_code?: string; purchase_date?: string }) => {
    try {
      const data = await apiPost<Cow>('/api/cows', payload)
      emitGlobalRefresh()
      return { error: null as any, data }
    } catch (error) {
      return { error, data: null as any }
    }
  }, [])
  return { create }
}

export function useUpdateCowStatus() {
  const update = useCallback(async (id: number, status: Cow['status']) => {
    try {
      await apiPatch(`/api/cows/${id}`, { status })
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [])
  return { update }
}

export function useAssignCowToGroup() {
  const assign = useCallback(async (cowId: number, groupId: number, startDate?: string) => {
    const sd = startDate ?? new Date().toISOString().slice(0, 10)
    try {
      await apiPost('/api/cow-assignments', { cow_id: cowId, group_id: groupId, start_date: sd })
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [])
  return { assign }
}


