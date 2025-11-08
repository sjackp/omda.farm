import { useMemo, useState } from 'react'
import { useCurrentCycle } from '../hooks/cycles'
import { useGroups, useCreateGroup, useGroupStats } from '../hooks/groups'
import { useFoodItems, useRecordUsage, useFeedMovements } from '../hooks/feed'
import type { HerdGroup } from '../hooks/groups'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { useToast } from '../providers/ToastProvider'
import { formatHumanDate } from '../lib/utils'
import { Link } from 'wouter'

export default function Groups() {
  const { data: current } = useCurrentCycle()
  const { data: groups = [], isLoading, refetch } = useGroups()
  const creator = useCreateGroup()
  const { addToast } = useToast()
  const { data: foodItems = [] } = useFoodItems()
  const { data: movements = [], isLoading: movementsLoading } = useFeedMovements()
  const usage = useRecordUsage()

  const [showCreate, setShowCreate] = useState(false)
  const [number, setNumber] = useState<number | ''>('')
  const [name, setName] = useState('')
  const [creating, setCreating] = useState(false)
  const [feedModalGroup, setFeedModalGroup] = useState<HerdGroup | null>(null)

  // Track checkbox selections and qty inputs per group and per food item
  const [selectedByGroup, setSelectedByGroup] = useState<Record<number, Record<number, boolean>>>({})
  const [qtyByGroup, setQtyByGroup] = useState<Record<number, Record<number, string>>>({})

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    if (!current?.id || number === '') return
    try {
      setCreating(true)
      const { error } = await creator.mutate({ cycle_id: current.id, number: Number(number), name })
      if (error) {
        addToast({ title: 'Failed to create group', description: String(error.message ?? error), type: 'error' })
        return
      }
      addToast({ title: 'Group created', type: 'success' })
      setNumber('')
      setName('')
    } finally {
      setCreating(false)
    }
  }

  const groupIds = useMemo(() => groups.map((g) => g.id), [groups])
  const { data: stats = {}, isLoading: statsLoading } = useGroupStats(groupIds, current?.id)

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="page-title">Groups</h1>
          <p className="muted">Manage herd groups in the current cycle</p>
        </div>
        <div className="flex items-center gap-2">
          <button className="rounded border px-3 py-1" onClick={() => refetch()}>Refresh</button>
          <button className="rounded border px-3 py-1" onClick={() => setShowCreate((v) => !v)}>
            {showCreate ? 'Close' : 'Add Group'}
          </button>
        </div>
      </div>

      {showCreate ? (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Create Group</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleCreate} className="flex flex-wrap gap-2 items-center">
              <input type="number" className="border rounded px-2 py-1 w-28" placeholder="Number" value={String(number)} onChange={(e) => setNumber(e.target.value === '' ? '' : Number(e.target.value))} />
              <input className="border rounded px-2 py-1 w-56" placeholder="Name (optional)" value={name} onChange={(e) => setName(e.target.value)} />
              <button type="submit" disabled={creating || number === '' || !current?.id} className="rounded bg-[#6B7A3A] hover:bg-[#5F6D3A] text-white px-3 py-2 disabled:opacity-50 disabled:cursor-not-allowed">Create</button>
            </form>
          </CardContent>
        </Card>
      ) : null}

      {isLoading ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <Card key={i} className="animate-pulse">
              <CardHeader>
                <div className="h-4 w-40 bg-slate-200 dark:bg-slate-800 rounded" />
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="h-3 w-32 bg-slate-200 dark:bg-slate-800 rounded" />
                <div className="h-10 w-full bg-slate-200 dark:bg-slate-800 rounded" />
              </CardContent>
            </Card>
          ))}
        </div>
      ) : groups.length === 0 ? (
        <div className="rounded border p-4">No groups yet</div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {groups.map((g: HerdGroup) => {
            const s = stats[g.id] ?? { totalCows: 0, totalFoodKg: 0 }
            return (
              <Card key={g.id}>
                <CardHeader className="flex flex-row items-center justify-between space-y-0">
                  <CardTitle className="text-base">
                    <Link href={`/groups/${g.id}`} className="text-[#6B7A3A] hover:underline">
                      Group #{g.number}{g.name ? ` — ${g.name}` : ''}
                    </Link>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-xs text-slate-500 mb-3">{g.active ? 'Active' : 'Inactive'}{g.group_type ? ` • ${g.group_type}` : ''}</div>
                  <div className="grid grid-cols-2 gap-3">
                    <div className="rounded border p-3">
                      <div className="text-xs text-slate-500">Total Cows (cycle)</div>
                      <div className="text-xl font-semibold">{statsLoading ? '—' : s.totalCows}</div>
                    </div>
                    <div className="rounded border p-3">
                      <div className="text-xs text-slate-500">Current Cows</div>
                      <div className="text-xl font-semibold">{statsLoading ? '—' : s.currentCows}</div>
                    </div>
                  </div>
                  <div className="mt-3">
                    <div className="text-xs text-slate-500 mb-2">Feed History</div>
                    <div className="max-h-56 overflow-auto space-y-2 pr-1 rounded border p-2">
                      {movementsLoading ? (
                        <div className="text-xs text-slate-500">Loading…</div>
                      ) : (
                        (() => {
                          const nameById: Record<number, string> = Object.fromEntries(foodItems.map((fi) => [fi.id, fi.name]))
                          const groupUsage = movements
                            .filter((m) => String(m.movement_type).toUpperCase() === 'USAGE' && String(m.usage_target_type).toLowerCase() === 'group' && m.group_id === g.id)
                            .sort((a, b) => new Date(b.movement_date).getTime() - new Date(a.movement_date).getTime())
                          if (groupUsage.length === 0) {
                            return <div className="text-xs text-slate-500">No feed yet</div>
                          }
                          return groupUsage.map((m) => (
                            <div key={m.id} className="flex items-center justify-between text-sm">
                              <div className="truncate">{nameById[m.food_item_id] ?? `Item ${m.food_item_id}`}</div>
                              <div className="ml-2 flex items-center gap-3 text-xs text-slate-600">
                                <span>{Number(m.qty_kg)} kg</span>
                                <span>{formatHumanDate(m.movement_date)}</span>
                              </div>
                            </div>
                          ))
                        })()
                      )}
                    </div>
                  </div>
                  <div className="mt-4 flex justify-center">
                    <button
                      className="rounded border px-3 py-2 text-sm"
                      onClick={async () => {
                        // Open modal to select feeds and quantities
                        // Reset any previous selections for this group
                        setSelectedByGroup((prev) => {
                          const next = { ...prev }
                          delete next[g.id]
                          return next
                        })
                        setQtyByGroup((prev) => {
                          const next = { ...prev }
                          delete next[g.id]
                          return next
                        })
                        setFeedModalGroup(g)
                      }}
                    >
                      Add Feed
                    </button>
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </div>
      )}

      {feedModalGroup ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
          <div className="w-full max-w-md rounded border bg-white dark:bg-slate-950 p-4">
            <div className="font-medium mb-2">Add Feed to Group #{feedModalGroup.number}{feedModalGroup.name ? ` — ${feedModalGroup.name}` : ''}</div>
            <div className="space-y-2 max-h-[70vh] overflow-auto pr-1">
              {foodItems.map((fi) => {
                const selectedMap = selectedByGroup[feedModalGroup.id] ?? {}
                const qtyMap = qtyByGroup[feedModalGroup.id] ?? {}
                const checked = !!selectedMap[fi.id]
                const qty = qtyMap[fi.id] ?? ''
                return (
                  <div key={fi.id} className="flex items-start gap-2">
                    <input
                      type="checkbox"
                      className="mt-1"
                      checked={checked}
                      onChange={(e) => {
                        setSelectedByGroup((prev) => {
                          const next = { ...prev }
                          const groupSel = { ...(next[feedModalGroup.id] ?? {}) }
                          groupSel[fi.id] = e.target.checked
                          next[feedModalGroup.id] = groupSel
                          return next
                        })
                      }}
                    />
                    <div className="flex-1">
                      <div className="text-sm">{fi.name}</div>
                      {checked ? (
                        <div className="mt-1">
                          <input
                            type="number"
                            step="0.01"
                            className="w-full border rounded px-2 py-1 text-sm"
                            placeholder="Quantity (kg)"
                            value={qty}
                            onChange={(e) => {
                              const v = e.target.value
                              setQtyByGroup((prev) => {
                                const next = { ...prev }
                                const groupQty = { ...(next[feedModalGroup.id] ?? {}) }
                                groupQty[fi.id] = v
                                next[feedModalGroup.id] = groupQty
                                return next
                              })
                            }}
                          />
                        </div>
                      ) : null}
                    </div>
                  </div>
                )
              })}
            </div>
            <div className="flex items-center justify-end gap-2 pt-3">
              <button className="rounded border px-3 py-1" onClick={() => setFeedModalGroup(null)}>Cancel</button>
              <button
                className="rounded bg-[#6B7A3A] hover:bg-[#5F6D3A] text-white px-3 py-1 disabled:opacity-50"
                disabled={!current?.id}
                onClick={async () => {
                  if (!current?.id) return
                  const groupId = feedModalGroup.id
                  const selectedMap = selectedByGroup[groupId] ?? {}
                  const qtyMap = qtyByGroup[groupId] ?? {}
                  const entries = Object.entries(selectedMap)
                    .filter(([, isChecked]) => isChecked)
                    .map(([foodId]) => {
                      const qtyStr = qtyMap[Number(foodId)] ?? ''
                      const qtyNum = Number(qtyStr)
                      return { foodId: Number(foodId), qtyNum }
                    })
                  const valid = entries.filter((e) => Number.isFinite(e.qtyNum) && e.qtyNum > 0)
                  if (valid.length === 0) return
                  let hadError = false
                  for (const entry of valid) {
                    const err = await usage.mutate({
                      cycle_id: current.id,
                      food_item_id: entry.foodId,
                      qty_kg: entry.qtyNum,
                      usage_target_type: 'group',
                      group_id: groupId,
                    })
                    if (err) {
                      hadError = true
                      addToast({ title: 'Failed to record feed usage', description: String((err as any)?.message || err), type: 'error' })
                    }
                  }
                  if (!hadError) {
                    addToast({ title: 'Feed recorded', type: 'success' })
                    // Clear selections for this group
                    setSelectedByGroup((prev) => {
                      const next = { ...prev }
                      delete next[groupId]
                      return next
                    })
                    setQtyByGroup((prev) => {
                      const next = { ...prev }
                      delete next[groupId]
                      return next
                    })
                    setFeedModalGroup(null)
                  }
                }}
              >
                Record
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  )
}


