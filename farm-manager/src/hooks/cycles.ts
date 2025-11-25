import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet } from '../lib/api'

export type FarmCycle = {
  id: number
  name: string
  start_date: string
  end_date: string | null
  created_at: string
}

export function useCycles() {
  const [data, setData] = useState<FarmCycle[] | undefined>(undefined)
  const [error, setError] = useState<unknown>(undefined)
  const [isLoading, setLoading] = useState(true)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      const rows = await apiGet<FarmCycle[]>('/api/cycles')
      // Normalize IDs coming from the API (which are strings for bigint columns)
      // so that we always work with numeric IDs on the client.
      const normalized = rows.map((r) => ({
        ...r,
        id: Number((r as any).id),
      }))
      setData(normalized)
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  return useMemo(() => ({ data, error, isLoading, refetch: fetcher }), [data, error, isLoading, fetcher])
}

const CURRENT_KEY = 'currentCycleId'

export function useCurrentCycle() {
  const { data } = useCycles()
  const stored = Number(localStorage.getItem(CURRENT_KEY) || '')
  const current = useMemo(() => {
    if (!data || !data.length) return null
    const byId = data.find((c) => c.id === stored)
    return byId ?? data[0]
  }, [data, stored])
  return { data: current }
}

export function useSetCurrentCycle() {
  const { refetch } = useCycles()
  const mutate = useCallback(async (cycleId: number) => {
    localStorage.setItem(CURRENT_KEY, String(cycleId))
    await refetch()
  }, [refetch])
  return { mutate }
}


