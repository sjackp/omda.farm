import { useMemo, useState } from 'react'
import { useCurrentCycle } from '../hooks/cycles'
import { useGroups, useCreateGroup, useToggleGroupActive, useGroupStats } from '../hooks/groups'
import { useFeedOnHand, useFoodItems, useRecordUsage } from '../hooks/feed'
import type { HerdGroup } from '../hooks/groups'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { useToast } from '../providers/ToastProvider'

export default function Groups() {
  const { data: current } = useCurrentCycle()
  const { data: groups = [], isLoading, refetch } = useGroups()
  const creator = useCreateGroup()
  const toggler = useToggleGroupActive()
  const { addToast } = useToast()
  const { data: onHand = [] } = useFeedOnHand()
  const { data: foodItems = [] } = useFoodItems()
  const usage = useRecordUsage()

  const [number, setNumber] = useState<number | ''>('')
  const [name, setName] = useState('')
  const [creating, setCreating] = useState(false)
  const [feedModalGroup, setFeedModalGroup] = useState<HerdGroup | null>(null)
  const [feedFoodId, setFeedFoodId] = useState<number | ''>('')
  const [feedQty, setFeedQty] = useState<string>('')

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
        <button className="rounded border px-3 py-1" onClick={() => refetch()}>Refresh</button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Create Group</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleCreate} className="flex flex-wrap gap-2 items-center">
            <input type="number" className="border rounded px-2 py-1 w-28" placeholder="Number" value={String(number)} onChange={(e) => setNumber(e.target.value === '' ? '' : Number(e.target.value))} />
            <input className="border rounded px-2 py-1 w-56" placeholder="Name (optional)" value={name} onChange={(e) => setName(e.target.value)} />
            <button type="submit" disabled={creating || number === '' || !current?.id} className="rounded bg-blue-600 text-white px-3 py-2 disabled:opacity-50 disabled:cursor-not-allowed">Create</button>
          </form>
        </CardContent>
      </Card>

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
                  <CardTitle className="text-base">Group #{g.number}{g.name ? ` — ${g.name}` : ''}</CardTitle>
                  <button className="text-xs rounded border px-2 py-1" onClick={() => toggler.toggle(g.id, !g.active)}>{g.active ? 'Deactivate' : 'Activate'}</button>
                </CardHeader>
                <CardContent>
                  <div className="text-xs text-slate-500 mb-3">{g.active ? 'Active' : 'Inactive'}{g.group_type ? ` • ${g.group_type}` : ''}</div>
                  <div className="grid grid-cols-2 gap-3">
                    <div className="rounded border p-3">
                      <div className="text-xs text-slate-500">Total Cows</div>
                      <div className="text-xl font-semibold">{statsLoading ? '—' : s.totalCows}</div>
                    </div>
                    <div className="rounded border p-3">
                      <div className="text-xs text-slate-500">Total Food (kg)</div>
                      <div className="text-xl font-semibold">{statsLoading ? '—' : s.totalFoodKg}</div>
                    </div>
                  </div>
                  <div className="mt-3 flex">
                    <button className="rounded border px-3 py-2 text-sm" onClick={() => { setFeedModalGroup(g); setFeedFoodId(''); setFeedQty('') }}>Add Feed</button>
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
            <div className="space-y-2">
              <select
                className="w-full border rounded px-2 py-1"
                value={feedFoodId === '' ? '' : String(feedFoodId)}
                onChange={(e) => setFeedFoodId(e.target.value === '' ? '' : Number(e.target.value))}
              >
                <option value="">Select feed</option>
                {onHand
                  .filter((f) => Number(f.on_hand_kg) > 0)
                  .map((f) => (
                    <option key={f.food_item_id} value={f.food_item_id}>
                      {(foodItems.find((fi) => fi.id === f.food_item_id)?.name) ?? `Item ${f.food_item_id}`} — {Number(f.on_hand_kg)} kg on hand
                    </option>
                  ))}
              </select>
              <input
                className="w-full border rounded px-2 py-1"
                type="number"
                step="0.01"
                placeholder="Quantity (kg)"
                value={feedQty}
                onChange={(e) => setFeedQty(e.target.value)}
              />
              <div className="flex items-center justify-end gap-2 pt-2">
                <button className="rounded border px-3 py-1" onClick={() => setFeedModalGroup(null)}>Cancel</button>
                <button
                  className="rounded bg-blue-600 text-white px-3 py-1 disabled:opacity-50"
                  disabled={!current?.id || feedFoodId === '' || !feedQty || Number(feedQty) <= 0}
                  onClick={async () => {
                    if (!current?.id || feedFoodId === '' || !feedQty) return
                    const qty = Number(feedQty)
                    if (!Number.isFinite(qty) || qty <= 0) return
                    const err = await usage.mutate({
                      cycle_id: current.id,
                      food_item_id: Number(feedFoodId),
                      qty_kg: qty,
                      usage_target_type: 'group',
                      group_id: feedModalGroup.id,
                    })
                    if (err) {
                      addToast({ title: 'Failed to record feed usage', description: String((err as any)?.message || err), type: 'error' })
                    } else {
                      addToast({ title: 'Feed recorded', type: 'success' })
                      setFeedModalGroup(null)
                    }
                  }}
                >
                  Record
                </button>
              </div>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  )
}


