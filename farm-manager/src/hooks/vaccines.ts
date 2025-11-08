import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPatch, apiPost } from '../lib/api'
import { emitGlobalRefresh, onGlobalRefresh } from '../lib/refresh'
import { useCurrentCycle } from './cycles'

export type Vaccine = {
  id: number
  name: string
  recurrence_days: number
  notes: string | null
  created_at: string
}

export function useVaccines() {
  const [data, setData] = useState<Vaccine[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      const rows = await apiGet<Vaccine[]>('/api/vaccines')
      setData(rows ?? [])
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useCreateVaccine() {
  const mutate = useCallback(async (payload: { name: string; recurrence_days: number; notes?: string }) => {
    const name = payload.name?.trim()
    if (!name) throw new Error('Name is required')
    if (!Number.isInteger(payload.recurrence_days) || payload.recurrence_days <= 0) {
      throw new Error('recurrence_days must be a positive integer')
    }
    const created = await apiPost<Vaccine>('/api/vaccines', {
      name,
      recurrence_days: payload.recurrence_days,
      notes: payload.notes?.trim() || null,
    })
    emitGlobalRefresh()
    return created
  }, [])
  return { mutate }
}

export function useUpdateVaccine() {
  const mutate = useCallback(async (id: number, payload: { name?: string; recurrence_days?: number; notes?: string }) => {
    if (!id) throw new Error('id is required')
    const body: Record<string, unknown> = {}
    if (typeof payload.name === 'string') {
      const name = payload.name.trim()
      if (!name) throw new Error('name cannot be empty')
      body.name = name
    }
    if (payload.recurrence_days !== undefined) {
      if (!Number.isInteger(payload.recurrence_days) || payload.recurrence_days <= 0) {
        throw new Error('recurrence_days must be a positive integer')
      }
      body.recurrence_days = payload.recurrence_days
    }
    if (typeof payload.notes === 'string') {
      body.notes = payload.notes.trim() || null
    }
    const updated = await apiPatch<Vaccine>(`/api/vaccines/${id}`, body)
    emitGlobalRefresh()
    return updated
  }, [])
  return { mutate }
}

export type VaccinationEvent = {
  id: number
  cow_id: number
  vaccine_id: number
  event_date: string
  notes: string | null
  created_at: string
  cow?: unknown
  vaccine?: unknown
}

export function useVaccinations(params?: { cycle_id?: number; cow_id?: number; vaccine_id?: number; from?: string; to?: string }) {
  const current = useCurrentCycle()
  const targetCycle = params?.cycle_id ?? current.data?.id

  const [data, setData] = useState<VaccinationEvent[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    const qp = new URLSearchParams()
    if (params?.cow_id) qp.set('cow_id', String(params.cow_id))
    if (params?.vaccine_id) qp.set('vaccine_id', String(params.vaccine_id))
    if (targetCycle && !params?.cow_id) qp.set('cycle_id', String(targetCycle))
    if (params?.from) qp.set('from', params.from)
    if (params?.to) qp.set('to', params.to)
    setLoading(true)
    try {
      const rows = await apiGet<VaccinationEvent[]>(`/api/vaccinations?${qp.toString()}`)
      setData(rows ?? [])
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [params?.cow_id, params?.vaccine_id, params?.from, params?.to, targetCycle])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useCreateVaccination() {
  const mutate = useCallback(async (payload: { cow_id: number; vaccine_id: number; event_date: string; notes?: string }) => {
    if (!payload.cow_id || !payload.vaccine_id || !payload.event_date) throw new Error('cow_id, vaccine_id, event_date are required')
    const res = await apiPost<VaccinationEvent | { skipped: true }>(`/api/vaccinations`, {
      cow_id: payload.cow_id,
      vaccine_id: payload.vaccine_id,
      event_date: payload.event_date,
      notes: payload.notes?.trim() || null,
    })
    emitGlobalRefresh()
    return res
  }, [])
  return { mutate }
}

export function useBulkVaccinations() {
  const mutate = useCallback(async (payload: { cow_ids: number[]; vaccine_ids: number[]; event_date: string; notes?: string }) => {
    const cows = Array.isArray(payload.cow_ids) ? payload.cow_ids : []
    const vaccines = Array.isArray(payload.vaccine_ids) ? payload.vaccine_ids : []
    if (cows.length === 0 || vaccines.length === 0 || !payload.event_date) throw new Error('cow_ids[], vaccine_ids[], event_date are required')
    const res = await apiPost<{ inserted: number; skipped_duplicates: number; total: number }>(`/api/vaccinations/bulk`, {
      cow_ids: cows,
      vaccine_ids: vaccines,
      event_date: payload.event_date,
      notes: payload.notes?.trim() || null,
    })
    emitGlobalRefresh()
    return res
  }, [])
  return { mutate }
}

export type VaccineDue = {
  cow_id: number
  vaccine_id: number
  last_event_date: string | null
  next_due_date: string
}

export function useVaccinesDue(params?: { cycle_id?: number; within_days?: number; vaccine_id?: number }) {
  const current = useCurrentCycle()
  const targetCycle = params?.cycle_id ?? current.data?.id
  const within = params?.within_days ?? 7
  const vaccineId = params?.vaccine_id

  const [data, setData] = useState<VaccineDue[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    if (!targetCycle) {
      setData([])
      setLoading(false)
      return
    }
    const qp = new URLSearchParams()
    qp.set('cycle_id', String(targetCycle))
    qp.set('within_days', String(within))
    if (vaccineId) qp.set('vaccine_id', String(vaccineId))
    setLoading(true)
    try {
      const rows = await apiGet<VaccineDue[]>(`/api/vaccines/due?${qp.toString()}`)
      setData(rows ?? [])
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [targetCycle, within, vaccineId])

  useEffect(() => {
    fetcher()
  }, [fetcher])

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}


