import { useMemo, useState } from 'react'
import { useCows, useCreateCow, useAssignCowToGroup } from '../hooks/cows'
import { useRecordWeighEvent } from '../hooks/weighs'
import { useCurrentCycle } from '../hooks/cycles'
import { useGroups } from '../hooks/groups'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'

export default function Herd() {
  const { data: cows = [], isLoading, refetch } = useCows()
  const creator = useCreateCow()
  const assigner = useAssignCowToGroup()
  const { data: groups = [], isLoading: groupsLoading } = useGroups()
  const recorder = useRecordWeighEvent()
  const current = useCurrentCycle()

  const [externalId, setExternalId] = useState('')
  const [breed, setBreed] = useState('')
  const [query, setQuery] = useState('')
  const [weight, setWeight] = useState<string>('')
  const [groupId, setGroupId] = useState<number | ''>('')
  const [purchasePrice, setPurchasePrice] = useState<string>('')
  const [purchaseCurrency, setPurchaseCurrency] = useState<string>('EGP')
  const [purchaseDate, setPurchaseDate] = useState<string>(() => new Date().toISOString().slice(0, 10))

  const [isSubmitting, setSubmitting] = useState(false)

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    if (!externalId || !groupId || !purchasePrice) return
    const cycleId = Number(current.data?.id || localStorage.getItem('currentCycleId') || 0) || 0
    if (!cycleId) return
    setSubmitting(true)
    const { data } = await creator.create({
      cycle_id: cycleId,
      external_id: externalId,
      breed,
      purchase_price: Number(purchasePrice),
      purchase_currency_code: purchaseCurrency || 'EGP',
      purchase_date: purchaseDate,
    })
    if (data?.id) {
      await assigner.assign(Number(data.id), Number(groupId))
      if (weight && !Number.isNaN(Number(weight))) {
        await recorder.create({ cow_id: Number(data.id), weight_kg: Number(weight) })
      }
    }
    setExternalId('')
    setBreed('')
    setWeight('')
    setGroupId('')
    setPurchasePrice('')
    setPurchaseCurrency('EGP')
    setPurchaseDate(new Date().toISOString().slice(0, 10))
    await refetch()
    setSubmitting(false)
  }

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase()
    if (!q) return cows
    return cows.filter((c) =>
      c.external_id.toLowerCase().includes(q) ||
      (c.breed ?? '').toLowerCase().includes(q) ||
      c.status.toLowerCase().includes(q)
    )
  }, [cows, query])

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="page-title">Herd</h1>
          <p className="muted">Manage animals in the current cycle</p>
        </div>
        <button className="rounded border px-3 py-1" onClick={() => refetch()}>Refresh</button>
      </div>

      <div className="grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-1">
          <CardHeader>
            <CardTitle className="text-base">Add Cow</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleCreate} className="flex flex-col gap-2">
              <input className="border rounded px-2 py-1" placeholder="External ID" value={externalId} onChange={(e) => setExternalId(e.target.value)} />
              <input className="border rounded px-2 py-1" placeholder="Breed (optional)" value={breed} onChange={(e) => setBreed(e.target.value)} />
              <input
                className="border rounded px-2 py-1"
                type="number"
                step="0.01"
                placeholder="Initial weight (kg, optional)"
                value={weight}
                onChange={(e) => setWeight(e.target.value)}
              />
              <div className="grid grid-cols-2 gap-2">
                <input
                  className="border rounded px-2 py-1"
                  placeholder="Purchase price"
                  type="number"
                  step="0.01"
                  value={purchasePrice}
                  onChange={(e) => setPurchasePrice(e.target.value)}
                />
                <input
                  className="border rounded px-2 py-1"
                  placeholder="Currency"
                  value={purchaseCurrency}
                  onChange={(e) => setPurchaseCurrency(e.target.value)}
                />
              </div>
              <input
                className="border rounded px-2 py-1"
                type="date"
                placeholder="Purchase date"
                value={purchaseDate}
                onChange={(e) => setPurchaseDate(e.target.value)}
              />
              <select
                className="border rounded px-2 py-1"
                value={groupId}
                onChange={(e) => setGroupId(e.target.value ? Number(e.target.value) : '')}
              >
                <option value="">Select group</option>
                {groups
                  .filter((g) => g.active)
                  .map((g) => (
                    <option key={g.id} value={g.id}>
                      Group {g.number}{g.name ? ` — ${g.name}` : ''}
                    </option>
                  ))}
              </select>
              <button
                type="submit"
                className="rounded bg-blue-600 text-white px-3 py-2 disabled:opacity-50"
                disabled={!externalId || !groupId || groupsLoading || isSubmitting}
              >
                {isSubmitting ? 'Adding…' : 'Add Cow'}
              </button>
            </form>
          </CardContent>
        </Card>

        <Card className="lg:col-span-2">
          <CardHeader>
            <div className="flex items-center justify-between gap-2">
              <CardTitle className="text-base">Herd List</CardTitle>
              <input
                className="border rounded px-2 py-1 w-48"
                placeholder="Search"
                value={query}
                onChange={(e) => setQuery(e.target.value)}
              />
            </div>
          </CardHeader>
          <CardContent>
            <div className="rounded border overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>External ID</TableHead>
                    <TableHead>Breed</TableHead>
                    <TableHead>Group</TableHead>
                    <TableHead>Current Weight (kg)</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Created</TableHead>
                    <TableHead className="text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {isLoading ? (
                    Array.from({ length: 5 }).map((_, i) => (
                      <TableRow key={i} className="animate-pulse">
                        <TableCell><div className="h-4 w-24 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell><div className="h-4 w-20 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell><div className="h-4 w-16 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell><div className="h-4 w-16 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell><div className="h-4 w-16 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell><div className="h-4 w-28 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                        <TableCell className="text-right"><div className="h-8 w-24 bg-slate-200 dark:bg-slate-800 rounded" /></TableCell>
                      </TableRow>
                    ))
                  ) : filtered.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={7} className="text-center text-sm text-slate-500">No cows found</TableCell>
                    </TableRow>
                  ) : (
                    filtered.map((c) => (
                      <TableRow key={c.id}>
                        <TableCell className="font-medium">{c.external_id}</TableCell>
                        <TableCell>{c.breed ?? '-'}</TableCell>
                        <TableCell>{c.current_group_number ? `Group ${c.current_group_number}` : '-'}</TableCell>
                        <TableCell>{c.latest_weight_kg ?? '-'}</TableCell>
                        <TableCell className="capitalize">{c.status}</TableCell>
                        <TableCell>{new Date(c.created_at).toLocaleDateString()}</TableCell>
                        <TableCell className="text-right">
                          <div className="inline-flex gap-2">
                            <button
                              className="text-sm rounded border px-2 py-1"
                              onClick={async () => {
                                const w = window.prompt('Enter current weight (kg)')
                                if (!w) return
                                const parsed = Number(w)
                                if (!Number.isFinite(parsed) || parsed <= 0) return
                                await recorder.create({ cow_id: c.id, weight_kg: parsed })
                              }}
                            >
                              Weigh In
                            </button>
                            {/* Removed Mark Sold / Mark Dead actions */}
                          </div>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}


