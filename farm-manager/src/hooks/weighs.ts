import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPost } from '../lib/api'
import { emitGlobalRefresh, onGlobalRefresh } from '../lib/refresh'
import { useCurrentCycle } from './cycles'

export type WeighEvent = {
  id: number
  cow_id: number
  weight_kg: string | number
  weighed_at: string
  notes: string | null
  created_at: string
}

export function useWeighEvents(cowId?: number, cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<WeighEvent[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      let rows: WeighEvent[] = []
      if (cowId) {
        rows = await apiGet<WeighEvent[]>(`/api/weigh-events?cow_id=${cowId}`)
      } else if (targetCycle) {
        rows = await apiGet<WeighEvent[]>(`/api/weigh-events?cycle_id=${targetCycle}`)
      }
      setData(rows)
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [cowId, targetCycle])

  useEffect(() => { fetcher() }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useRecordWeighEvent() {
  const { refetch } = useWeighEvents()

  const create = useCallback(async (payload: { cow_id: number; weight_kg: number; weighed_at?: string; notes?: string }) => {
    const body = {
      cow_id: payload.cow_id,
      weight_kg: payload.weight_kg,
      weighed_at: payload.weighed_at ?? new Date().toISOString().slice(0, 10),
      notes: payload.notes ?? null,
    }
    try {
      await apiPost('/api/weigh-events', body)
      await refetch()
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [refetch])

  return { create }
}


