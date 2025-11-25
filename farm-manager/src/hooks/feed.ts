import { useCallback, useEffect, useMemo, useState } from 'react'
import { apiGet, apiPost } from '../lib/api'
import { emitGlobalRefresh, onGlobalRefresh } from '../lib/refresh'
import { useCurrentCycle } from './cycles'

export type FeedOnHand = {
  // On-hand is global across cycles; we keep cycle_id optional for backward
  // compatibility with any existing data, but the UI does not depend on it.
  cycle_id?: number
  food_item_id: number
  on_hand_kg: string | number
}

export type FeedMovement = {
  id: number
  cycle_id: number
  food_item_id: number
  movement_date: string
  qty_kg: string | number
  movement_type: string
  usage_target_type: string | null
  group_id: number | null
  cow_id: number | null
  unit_cost: string | null
  total_cost: string | null
  currency_code: string | null
  reference: string | null
  notes: string | null
  created_at: string
}

export function useFeedOnHand() {
  const [data, setData] = useState<FeedOnHand[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      const rows = await apiGet<FeedOnHand[]>('/api/feed/on-hand')
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

export function useFeedMovements(cycleId?: number) {
  const current = useCurrentCycle()
  const targetCycle = cycleId ?? current.data?.id

  const [data, setData] = useState<FeedMovement[]>([])
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
      const rows = await apiGet<FeedMovement[]>(`/api/feed/movements?cycle_id=${targetCycle}`)
      setData(rows ?? [])
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

export function useRecordSupply() {
  const { refetch: refetchOnHand } = useFeedOnHand()
  const { refetch: refetchMovements } = useFeedMovements()

  const mutate = useCallback(async (payload: {
    cycle_id: number
    food_item_id: number
    movement_date?: string
    qty_kg: number
    unit_cost?: number
    total_cost?: number
    currency_code?: string
    expense_id?: number
    reference?: string
    notes?: string
  }) => {
    const body = {
      cycle_id: payload.cycle_id,
      food_item_id: payload.food_item_id,
      movement_date: payload.movement_date ?? new Date().toISOString().slice(0, 10),
      qty_kg: payload.qty_kg,
      movement_type: 'SUPPLY',
      unit_cost: payload.unit_cost ?? null,
      total_cost: payload.total_cost ?? null,
      currency_code: payload.currency_code ?? null,
      expense_id: payload.expense_id ?? null,
      reference: payload.reference ?? null,
      notes: payload.notes ?? null,
    }

    try {
      await apiPost('/api/feed/supply', body)
      await refetchOnHand()
      await refetchMovements()
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [refetchOnHand, refetchMovements])

  return { mutate }
}

export function useRecordUsage() {
  const { refetch: refetchOnHand } = useFeedOnHand()
  const { refetch: refetchMovements } = useFeedMovements()

  const mutate = useCallback(async (payload: {
    cycle_id: number
    food_item_id: number
    movement_date?: string
    qty_kg: number
    usage_target_type: 'group' | 'cow'
    group_id?: number
    cow_id?: number
    notes?: string
  }) => {
    const body = {
      cycle_id: payload.cycle_id,
      food_item_id: payload.food_item_id,
      movement_date: payload.movement_date ?? new Date().toISOString().slice(0, 10),
      qty_kg: payload.qty_kg,
      movement_type: 'USAGE',
      usage_target_type: payload.usage_target_type,
      group_id: payload.group_id ?? null,
      cow_id: payload.cow_id ?? null,
      notes: payload.notes ?? null,
    }

    try {
      await apiPost('/api/feed/usage', body)
      await refetchOnHand()
      await refetchMovements()
      emitGlobalRefresh()
      return null
    } catch (e) {
      return e
    }
  }, [refetchOnHand, refetchMovements])

  return { mutate }
}

export type FoodItem = { id: number; name: string; unit?: string; notes?: string | null }

export function useFoodItems() {
  const [data, setData] = useState<FoodItem[]>([])
  const [isLoading, setLoading] = useState(true)
  const [error, setError] = useState<unknown>(undefined)

  const fetcher = useCallback(async () => {
    setLoading(true)
    try {
      const rows = await apiGet<FoodItem[]>('/api/food-items')
      // Ensure ids are numbers for consistent keying/comparisons in UI
      const normalized = (rows ?? []).map((r: any) => ({ ...r, id: Number(r.id) }))
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

  useEffect(() => {
    const off = onGlobalRefresh(fetcher)
    return off
  }, [fetcher])

  return useMemo(() => ({ data, isLoading, error, refetch: fetcher }), [data, isLoading, error, fetcher])
}

export function useCreateFoodItem() {
  const mutate = useCallback(async (payload: { name: string; unit?: string; notes?: string }) => {
    const name = payload.name?.trim()
    if (!name) throw new Error('Name is required')

    const unit = payload.unit && payload.unit.trim() ? payload.unit.trim() : 'kg'
    const notes = payload.notes && payload.notes.trim() ? payload.notes.trim() : undefined

    const created = await apiPost<FoodItem>('/api/food-items', {
      name,
      unit,
      notes: notes ?? null,
    })

    emitGlobalRefresh()

    return created
  }, [])

  return { mutate }
}


