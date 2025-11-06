import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPatch, apiPost } from '../lib/api'
import { emitGlobalRefresh, onGlobalRefresh } from '../lib/refresh'
import { useCurrentCycle } from './cycles'

export type HerdGroup = {
  id: number
  cycle_id: number
  number: number
  name: string | null
  group_type: string | null
  active: boolean
  notes: string | null
  created_at: string
}

export function useGroups(cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<HerdGroup[] | undefined>(undefined)
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
      const rows = await apiGet<HerdGroup[]>(`/api/groups?cycle_id=${targetCycle}`)
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

export function useCreateGroup() {
  const mutate = useCallback(async (payload: { cycle_id: number; number: number; name?: string; group_type?: string }) => {
    try {
      const data = await apiPost<HerdGroup>('/api/groups', payload)
      emitGlobalRefresh()
      return { data, error: null as any }
    } catch (error) {
      return { data: null as any, error }
    }
  }, [])
  return { mutate }
}

export function useToggleGroupActive() {
  const toggle = useCallback(async (id: number, active: boolean) => {
    try {
      await apiPatch(`/api/groups/${id}`, { active })
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [])
  return { toggle }
}


export type GroupStats = {
  totalCows: number
  totalFoodKg: number
}

export function useGroupStats(groupIds: number[], cycleId?: number) {
  const [data, setData] = useState<Record<number, GroupStats>>({})
  const [isLoading, setLoading] = useState<boolean>(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    if (!cycleId || !groupIds.length) {
      setData({})
      setLoading(false)
      return
    }
    setLoading(true)
    try {
      const query = `/api/group-stats?cycle_id=${cycleId}&ids=${groupIds.join(',')}`
      const next = await apiGet<Record<number, GroupStats>>(query)
      setData(next)
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [cycleId, groupIds])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}


