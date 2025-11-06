import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPost } from '../lib/api'
import { useCurrentCycle } from './cycles'
import type { Cow } from './cows'

export type Sale = {
  id: number
  cow_id: number
  buyer_id: number
  date_sold: string
  weight_at_sale_kg: string | number
  price_per_kg: string | number
  currency_code: string
  notes: string | null
  created_at: string
  cow?: Cow
  buyer?: { id: number; name: string }
}

export function useSales(cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<Sale[]>([])
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
      const rows = await apiGet<any[]>(`/api/sales?cycle_id=${targetCycle}`)
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

export function useCreateSale() {
  const { refetch } = useSales()

  const create = useCallback(async (payload: { cow_id: number; buyer_id: number; date_sold: string; weight_at_sale_kg: number; price_per_kg: number; currency_code?: string; notes?: string }) => {
    const body = {
      cow_id: payload.cow_id,
      buyer_id: payload.buyer_id,
      date_sold: payload.date_sold,
      weight_at_sale_kg: payload.weight_at_sale_kg,
      price_per_kg: payload.price_per_kg,
      currency_code: payload.currency_code ?? 'EGP',
      notes: payload.notes ?? null,
    }
    try {
      const data = await apiPost('/api/sales', body)
      await refetch()
      return { error: null as any, data }
    } catch (error) {
      return { error, data: null as any }
    }
  }, [refetch])

  return { create }
}


