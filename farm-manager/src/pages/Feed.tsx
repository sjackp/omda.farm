import { useMemo, useState } from 'react'
import { useCreateFoodItem, useFeedOnHand, useFeedMovements, useFoodItems, useRecordSupply } from '../hooks/feed'
import { useCurrentCycle } from '../hooks/cycles'
import Button from '../components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'
import { Badge } from '../components/ui/badge'

export default function Feed() {
  const { data: onHand = [], isLoading: onHandLoading } = useFeedOnHand()
  const { data: movements = [], isLoading: movLoading } = useFeedMovements()
  const { data: items = [], isLoading: itemsLoading } = useFoodItems()
  const { data: currentCycle } = useCurrentCycle()

  const supply = useRecordSupply()
  const { mutate: createFoodItem } = useCreateFoodItem()

  const [showCreateType, setShowCreateType] = useState(false)
  const [showRestock, setShowRestock] = useState(false)

  const [supplyFoodId, setSupplyFoodId] = useState<number | ''>('')
  const [supplyQty, setSupplyQty] = useState('')
  const [unitCost, setUnitCost] = useState('')
  const [supplyNotes, setSupplyNotes] = useState('')
  const [submittingSupply, setSubmittingSupply] = useState(false)

  

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

  async function handleSupplySubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!currentCycle?.id || !supplyFoodId || !supplyQty) return
    setSubmittingSupply(true)
    await supply.mutate({
      cycle_id: currentCycle.id,
      food_item_id: Number(supplyFoodId),
      qty_kg: Number(supplyQty),
      unit_cost: unitCost ? Number(unitCost) : undefined,
      notes: supplyNotes || undefined,
    })
    setSubmittingSupply(false)
    setSupplyQty('')
    setUnitCost('')
    setSupplyNotes('')
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
      const created = await createFoodItem({
        name,
        unit: newFeedUnit.trim() || 'kg',
        notes: newFeedNotes.trim() || undefined,
      })
      setNewFeedName('')
      setNewFeedUnit('kg')
      setNewFeedNotes('')
      if (created?.id) {
        setSupplyFoodId(created.id)
      }
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

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Inventory on hand</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Feed</TableHead>
                  <TableHead className="text-right">On hand (kg)</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {(onHandLoading || itemsLoading) && (
                  <TableRow>
                    <TableCell colSpan={2} className="text-center text-slate-500">Loading…</TableCell>
                  </TableRow>
                )}
                {!onHandLoading && !itemsLoading && (items || []).map((it) => {
                  const qty = onHandByItem.get(it.id) || 0
                  const low = qty <= 25
                  return (
                    <TableRow key={it.id}>
                      <TableCell className="flex items-center gap-2">
                        <span>{it.name}</span>
                        {low && <Badge variant="destructive">Low</Badge>}
                      </TableCell>
                      <TableCell className="text-right">{qty.toLocaleString()} kg</TableCell>
                    </TableRow>
                  )
                })}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <div className="grid gap-4">
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
          {showRestock ? (
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Restock (Supply)</CardTitle>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSupplySubmit} className="grid grid-cols-1 gap-3">
                  <select
                    className="border rounded-md px-3 py-2"
                    value={String(supplyFoodId)}
                    onChange={(e) => setSupplyFoodId(e.target.value === '' ? '' : Number(e.target.value))}
                  >
                    <option value="">Select feed</option>
                    {(items || []).map((f) => (
                      <option key={f.id} value={f.id}>{f.name}</option>
                    ))}
                  </select>
                  <div className="grid grid-cols-2 gap-3">
                    <input
                      className="border rounded-md px-3 py-2"
                      placeholder="Qty (kg)"
                      inputMode="decimal"
                      value={supplyQty}
                      onChange={(e) => setSupplyQty(e.target.value)}
                    />
                    <input
                      className="border rounded-md px-3 py-2"
                      placeholder="Unit cost (optional)"
                      inputMode="decimal"
                      value={unitCost}
                      onChange={(e) => setUnitCost(e.target.value)}
                    />
                  </div>
                  <input
                    className="border rounded-md px-3 py-2"
                    placeholder="Notes (optional)"
                    value={supplyNotes}
                    onChange={(e) => setSupplyNotes(e.target.value)}
                  />
                  <div className="flex justify-end">
                    <Button disabled={!currentCycle?.id || !supplyFoodId || !supplyQty || submittingSupply}>
                      {submittingSupply ? 'Saving…' : 'Record Supply'}
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>
          ) : null}

          
        </div>
      </div>

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


