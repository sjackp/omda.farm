import { useMemo, useState } from 'react'
import { useCreateFoodItem, useFeedOnHand, useFeedMovements, useFoodItems, useRecordSupply } from '../hooks/feed'
import { useCurrentCycle } from '../hooks/cycles'
import Button from '../components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'
import { Badge } from '../components/ui/badge'
import { useToast } from '../providers/ToastProvider'

export default function Feed() {
  const { data: onHand = [], isLoading: onHandLoading } = useFeedOnHand()
  const { data: movements = [], isLoading: movLoading } = useFeedMovements()
  const { data: items = [], isLoading: itemsLoading } = useFoodItems()
  const { data: currentCycle } = useCurrentCycle()

  const supply = useRecordSupply()
  const { mutate: createFoodItem } = useCreateFoodItem()
  const { addToast } = useToast()

  const [showCreateType, setShowCreateType] = useState(false)
  const [showRestock, setShowRestock] = useState(false)

  

  

  const [newFeedName, setNewFeedName] = useState('')
  const [newFeedUnit, setNewFeedUnit] = useState('kg')
  const [newFeedNotes, setNewFeedNotes] = useState('')
  const [creatingFeed, setCreatingFeed] = useState(false)
  const [createFeedError, setCreateFeedError] = useState<string | null>(null)

  const [filterFoodId, setFilterFoodId] = useState<number | ''>('')
  const [filterType, setFilterType] = useState<'ALL' | 'SUPPLY' | 'USAGE'>('ALL')

  const onHandByItem = useMemo(() => {
    const map = new Map<number, number>()
    for (const row of onHand as any[]) {
      map.set(Number(row.food_item_id), Number(row.on_hand_kg))
    }
    return map
  }, [onHand])

  const filteredMovements = useMemo(() => {
    return (movements || []).filter((m: any) => {
      if (filterType !== 'ALL' && String(m.movement_type).toUpperCase() !== filterType) return false
      if (filterFoodId && Number(m.food_item_id) !== Number(filterFoodId)) return false
      return true
    })
  }, [movements, filterFoodId, filterType])

  const maxOnHand = useMemo(() => {
    let max = 0
    for (const it of (items || [])) {
      const qty = onHandByItem.get(it.id) || 0
      if (qty > max) max = qty
    }
    return max || 1
  }, [items, onHandByItem])

  

  const [bulkSelected, setBulkSelected] = useState<Record<number, boolean>>({})
  const [bulkQtyById, setBulkQtyById] = useState<Record<number, string>>({})
  const [bulkCostById, setBulkCostById] = useState<Record<number, string>>({})
  const [bulkNotesById, setBulkNotesById] = useState<Record<number, string>>({})
  const [bulkSubmitting, setBulkSubmitting] = useState(false)

  async function handleBulkSupplySubmit() {
    if (!currentCycle?.id) return
    const entries = Object.entries(bulkSelected)
      .filter(([, checked]) => checked)
      .map(([id]) => {
        const qtyStr = bulkQtyById[Number(id)] ?? ''
        const qtyNum = Number(qtyStr)
        const costStr = bulkCostById[Number(id)] ?? ''
        const notesStr = bulkNotesById[Number(id)] ?? ''
        return {
          foodId: Number(id),
          qtyNum,
          costNum: costStr ? Number(costStr) : undefined,
          notes: notesStr ? notesStr : undefined,
        }
      })
      .filter((e) => Number.isFinite(e.qtyNum) && e.qtyNum > 0)
    if (entries.length === 0) return
    setBulkSubmitting(true)
    let hadError = false
    for (const entry of entries) {
      const err = await supply.mutate({
        cycle_id: currentCycle.id,
        food_item_id: entry.foodId,
        qty_kg: entry.qtyNum,
        unit_cost: entry.costNum,
        notes: entry.notes,
      })
      if (err) {
        hadError = true
        addToast({ title: 'Failed to record supply', description: String((err as any)?.message || err), type: 'error' })
      }
    }
    setBulkSubmitting(false)
    if (!hadError) {
      addToast({ title: 'Supply recorded', description: `Recorded ${entries.length} item(s)`, type: 'success' })
      setBulkSelected({})
      setBulkQtyById({})
      setBulkCostById({})
      setBulkNotesById({})
      setShowRestock(false)
    }
  }

  

  async function handleCreateFeedType(e: React.FormEvent) {
    e.preventDefault()
    const name = newFeedName.trim()
    if (!name) {
      setCreateFeedError('Name is required')
      return
    }

    setCreatingFeed(true)
    setCreateFeedError(null)
    try {
      await createFoodItem({
        name,
        unit: newFeedUnit.trim() || 'kg',
        notes: newFeedNotes.trim() || undefined,
      })
      setNewFeedName('')
      setNewFeedUnit('kg')
      setNewFeedNotes('')
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to create feed type'
      setCreateFeedError(message)
    } finally {
      setCreatingFeed(false)
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-end justify-between">
        <div>
          <h1 className="text-xl font-semibold">Feed</h1>
          <p className="text-sm text-slate-600">Track inventory and restock supplies.</p>
        </div>
        <div className="flex items-center gap-2">
          <button className="rounded border px-3 py-1" onClick={() => setShowCreateType((v) => !v)}>
            {showCreateType ? 'Close' : 'Add Feed Type'}
          </button>
          <button className="rounded border px-3 py-1" onClick={() => setShowRestock((v) => !v)}>
            {showRestock ? 'Close' : 'Restock'}
          </button>
        </div>
      </div>

      {showCreateType ? (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Feed types</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <form onSubmit={handleCreateFeedType} className="grid grid-cols-1 gap-3">
              <input
                className="border rounded-md px-3 py-2"
                placeholder="Name"
                value={newFeedName}
                onChange={(e) => setNewFeedName(e.target.value)}
              />
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                <input
                  className="border rounded-md px-3 py-2"
                  placeholder="Unit"
                  value={newFeedUnit}
                  onChange={(e) => setNewFeedUnit(e.target.value)}
                />
                <input
                  className="border rounded-md px-3 py-2"
                  placeholder="Notes (optional)"
                  value={newFeedNotes}
                  onChange={(e) => setNewFeedNotes(e.target.value)}
                />
              </div>
              {createFeedError && <p className="text-sm text-red-600">{createFeedError}</p>}
              <div className="flex justify-end">
                <Button type="submit" disabled={creatingFeed}>
                  {creatingFeed ? 'Saving…' : 'Add Feed Type'}
                </Button>
              </div>
            </form>
            <div>
              <p className="text-xs text-slate-500 mb-2">Existing feed types</p>
              {itemsLoading ? (
                <p className="text-sm text-slate-500">Loading…</p>
              ) : (items || []).length === 0 ? (
                <p className="text-sm text-slate-500">No feed types yet.</p>
              ) : (
                <div className="flex flex-wrap gap-2">
                  {(items || []).map((it) => (
                    <Badge key={it.id} variant="outline">
                      {it.name}
                      {it.unit ? ` (${it.unit})` : ''}
                    </Badge>
                  ))}
                </div>
              )}
            </div>
          </CardContent>
        </Card>
      ) : null}

      {/* Restock is integrated inside the inventory card below */}

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Inventory on hand</CardTitle>
        </CardHeader>
        <CardContent>
          {(onHandLoading || itemsLoading) && (
            <p className="text-sm text-slate-500">Loading…</p>
          )}
          {!onHandLoading && !itemsLoading && (items || []).length === 0 && (
            <p className="text-sm text-slate-500">No feed types yet. Add a feed type to get started.</p>
          )}
          {!onHandLoading && !itemsLoading && (items || []).length > 0 && (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {(items || []).map((it) => {
                const qty = onHandByItem.get(it.id) || 0
                const low = qty <= 25
                const percent = Math.min(100, Math.max(0, (qty / maxOnHand) * 100))
                const ringColor = low ? '#f43f5e' : '#10b981'
                const trackColor = '#e2e8f0'
                return (
                  <div key={it.id} className="border rounded-lg p-4 bg-white dark:bg-slate-950">
                    <div className="flex items-center gap-4">
                      <div className="relative" style={{ width: 64, height: 64 }}>
                        <div
                          className="w-full h-full rounded-full"
                          style={{
                            background: `conic-gradient(${ringColor} ${percent}%, ${trackColor} ${percent}% 100%)`,
                          }}
                          aria-hidden="true"
                        />
                        <div className="absolute inset-0 flex items-center justify-center">
                          <div className="w-12 h-12 rounded-full bg-white dark:bg-slate-950 flex items-center justify-center">
                            <span className="text-xs font-medium tabular-nums">{qty.toLocaleString()}</span>
                          </div>
                        </div>
                      </div>
                      <div className="min-w-0">
                        <div className="flex items-center gap-2">
                          <p className="font-medium truncate">{it.name}</p>
                          {low && <Badge variant="destructive">Low</Badge>}
                        </div>
                        <p className="text-xs text-slate-500">{qty.toLocaleString()} kg</p>
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>
          )}
          {showRestock && !onHandLoading && !itemsLoading && (items || []).length > 0 ? (
            <div className="mt-6 border-t pt-4">
              <div className="flex items-center justify-between">
                <div className="font-medium text-sm">Bulk Restock</div>
                <div className="flex items-center gap-3 text-xs">
                  <label className="inline-flex items-center gap-1">
                    <input
                      type="checkbox"
                      checked={(items || []).every((it) => !!bulkSelected[it.id]) && (items || []).length > 0}
                      onChange={(e) => {
                        const checked = e.target.checked
                        setBulkSelected(() => {
                          const next: Record<number, boolean> = {}
                          for (const it of (items || [])) next[it.id] = checked
                          return next
                        })
                      }}
                    />
                    <span>Select all</span>
                  </label>
                  <button
                    className="rounded border px-2 py-1"
                    onClick={() => {
                      setBulkSelected({})
                      setBulkQtyById({})
                      setBulkCostById({})
                      setBulkNotesById({})
                    }}
                  >
                    Clear
                  </button>
                </div>
              </div>
              <div className="mt-3 max-h-80 overflow-auto space-y-3 pr-1">
                {(items || []).map((it) => {
                  const checked = !!bulkSelected[it.id]
                  const qty = bulkQtyById[it.id] ?? ''
                  const cost = bulkCostById[it.id] ?? ''
                  const notes = bulkNotesById[it.id] ?? ''
                  return (
                    <div key={it.id} className="flex items-start gap-2">
                      <input
                        type="checkbox"
                        className="mt-1"
                        checked={checked}
                        onChange={(e) => {
                          const c = e.target.checked
                          setBulkSelected((prev) => ({ ...prev, [it.id]: c }))
                        }}
                      />
                      <div className="flex-1">
                        <div className="text-sm">{it.name}</div>
                        {checked ? (
                          <div className="mt-2 grid grid-cols-1 sm:grid-cols-3 gap-2">
                            <input
                              className="border rounded-md px-3 py-2 text-sm"
                              placeholder="Qty (kg)"
                              inputMode="decimal"
                              value={qty}
                              onChange={(e) => setBulkQtyById((prev) => ({ ...prev, [it.id]: e.target.value }))}
                            />
                            <input
                              className="border rounded-md px-3 py-2 text-sm"
                              placeholder="Unit cost (optional)"
                              inputMode="decimal"
                              value={cost}
                              onChange={(e) => setBulkCostById((prev) => ({ ...prev, [it.id]: e.target.value }))}
                            />
                            <input
                              className="border rounded-md px-3 py-2 text-sm"
                              placeholder="Notes (optional)"
                              value={notes}
                              onChange={(e) => setBulkNotesById((prev) => ({ ...prev, [it.id]: e.target.value }))}
                            />
                          </div>
                        ) : null}
                      </div>
                    </div>
                  )
                })}
              </div>
              <div className="flex items-center justify-end gap-2 pt-3">
                <button className="rounded border px-3 py-1" onClick={() => setShowRestock(false)}>Cancel</button>
                <button
                  className="rounded bg-blue-600 text-white px-3 py-1 disabled:opacity-50"
                  disabled={!currentCycle?.id || bulkSubmitting}
                  onClick={handleBulkSupplySubmit}
                >
                  {bulkSubmitting ? 'Saving…' : 'Record Supply'}
                </button>
              </div>
            </div>
          ) : null}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <div className="flex items-center justify-between gap-2">
            <CardTitle className="text-base">Recent movements</CardTitle>
            <div className="flex items-center gap-2">
              <select
                className="border rounded-md px-2 py-1 h-9"
                value={String(filterFoodId)}
                onChange={(e) => setFilterFoodId(e.target.value === '' ? '' : Number(e.target.value))}
              >
                <option value="">All feeds</option>
                {(items || []).map((f) => (
                  <option key={f.id} value={f.id}>{f.name}</option>
                ))}
              </select>
              <select
                className="border rounded-md px-2 py-1 h-9"
                value={filterType}
                onChange={(e) => setFilterType(e.target.value as any)}
              >
                <option value="ALL">All types</option>
                <option value="SUPPLY">Supply</option>
                <option value="USAGE">Usage</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Date</TableHead>
                <TableHead>Feed</TableHead>
                <TableHead>Type</TableHead>
                <TableHead className="text-right">Qty (kg)</TableHead>
                <TableHead>Target</TableHead>
                <TableHead>Notes</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {movLoading && (
                <TableRow>
                  <TableCell colSpan={6} className="text-center text-slate-500">Loading…</TableCell>
                </TableRow>
              )}
              {!movLoading && filteredMovements.map((m: any) => {
                const item = (items || []).find((f) => f.id === m.food_item_id)
                const type = String(m.movement_type).toUpperCase()
                const date = m.movement_date
                const target = type === 'USAGE' && m.usage_target_type === 'group' && m.group_id
                  ? `Group ${m.group_id}`
                  : ''
                return (
                  <TableRow key={m.id}>
                    <TableCell>{date}</TableCell>
                    <TableCell>{item?.name ?? `Item ${m.food_item_id}`}</TableCell>
                    <TableCell>{type}</TableCell>
                    <TableCell className="text-right">{Number(m.qty_kg).toLocaleString()}</TableCell>
                    <TableCell>{target}</TableCell>
                    <TableCell>{m.notes || ''}</TableCell>
                  </TableRow>
                )
              })}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  )
}


