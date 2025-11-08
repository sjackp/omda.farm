import { useState } from 'react'
import { useVaccines, useCreateVaccine, useVaccinesDue, useVaccinations, useBulkVaccinations } from '../hooks/vaccines'
import { useCows } from '../hooks/cows'
import { useCurrentCycle } from '../hooks/cycles'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'
import ScrollablePanel from '../components/ui/ScrollablePanel'
import Button from '../components/ui/button'
import { useToast } from '../providers/ToastProvider'

type Tab = 'catalog' | 'due' | 'records'

export default function Vaccines() {
  const [tab, setTab] = useState<Tab>('due')

  return (
    <div className="space-y-6">
      <div className="flex items-end justify-between">
        <div>
          <h1 className="text-xl font-semibold">Vaccines</h1>
          <p className="text-sm text-slate-600">Manage vaccines, see what’s due, and record vaccinations.</p>
        </div>
        <div className="flex items-center gap-2">
          <button className={`rounded border px-3 py-1 ${tab === 'due' ? 'bg-slate-100 dark:bg-slate-900' : ''}`} onClick={() => setTab('due')}>Due</button>
          <button className={`rounded border px-3 py-1 ${tab === 'catalog' ? 'bg-slate-100 dark:bg-slate-900' : ''}`} onClick={() => setTab('catalog')}>Catalog</button>
        </div>
      </div>

{tab === 'catalog' ? <CatalogTab /> : null}
{tab === 'due' ? <DueTab /> : null}
    </div>
  )
}

function CatalogTab() {
  const { data: vaccines = [], isLoading } = useVaccines()
  const { mutate: createVaccine } = useCreateVaccine()
  const { addToast } = useToast()

  const [name, setName] = useState('')
  const [recurrence, setRecurrence] = useState<string>('30')
  const [notes, setNotes] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    const n = name.trim()
    const r = Number(recurrence)
    if (!n) return setError('Name is required')
    if (!Number.isInteger(r) || r <= 0) return setError('Recurrence days must be positive')
    setSubmitting(true)
    setError(null)
    try {
      await createVaccine({ name: n, recurrence_days: r, notes: notes.trim() || undefined })
      setName('')
      setRecurrence('30')
      setNotes('')
      addToast({ title: 'Vaccine created', type: 'success' })
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Failed to create vaccine')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="space-y-4">
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Add vaccine</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleCreate} className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <input className="border rounded-md px-3 py-2" placeholder="Name" value={name} onChange={(e) => setName(e.target.value)} />
            <input className="border rounded-md px-3 py-2" placeholder="Recurrence days" inputMode="numeric" value={recurrence} onChange={(e) => setRecurrence(e.target.value)} />
            <input className="border rounded-md px-3 py-2 md:col-span-2" placeholder="Notes (optional)" value={notes} onChange={(e) => setNotes(e.target.value)} />
            {error && <p className="text-sm text-red-600 md:col-span-3">{error}</p>}
            <div className="md:col-span-3 flex justify-end">
              <Button type="submit" disabled={submitting}>{submitting ? 'Saving…' : 'Add Vaccine'}</Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Vaccines</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {isLoading ? (
            <p className="p-3 text-sm text-slate-600">Loading…</p>
          ) : vaccines.length === 0 ? (
            <p className="p-3 text-sm text-slate-600">No vaccines yet.</p>
          ) : (
            <ScrollablePanel maxHeight={360}>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Name</TableHead>
                    <TableHead>Every (days)</TableHead>
                    <TableHead>Notes</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {vaccines.map((v) => (
                    <TableRow key={v.id}>
                      <TableCell className="font-medium">{v.name}</TableCell>
                      <TableCell>{v.recurrence_days}</TableCell>
                      <TableCell>{v.notes || ''}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </ScrollablePanel>
          )}
        </CardContent>
      </Card>
    </div>
  )
}

function DueTab() {
  const { data: currentCycle } = useCurrentCycle()
  const [withinDays, setWithinDays] = useState<string>('7')
  const within = Number(withinDays) || 0
  const { data: due = [], isLoading } = useVaccinesDue({ within_days: within })
  const { data: vaccines = [] } = useVaccines()
  const { data: cows = [] } = useCows()
  const { mutate: bulkVaccinate } = useBulkVaccinations()
  const { addToast } = useToast()
  const { data: vaccinations = [], isLoading: recordsLoading } = useVaccinations()

  // Selection state
  const [selectedVaccineIds, setSelectedVaccineIds] = useState<Record<number, boolean>>({})
  const [selectedCowIds, setSelectedCowIds] = useState<Record<number, boolean>>({})
  const [eventDate, setEventDate] = useState<string>(() => new Date().toISOString().slice(0, 10))
  const [notes, setNotes] = useState('')
  const [submitting, setSubmitting] = useState(false)

  // derived structures can be added later if needed

  async function handleBulkApply() {
    const cowIds = Object.entries(selectedCowIds).filter(([, v]) => v).map(([k]) => Number(k))
    const vaccineIds = Object.entries(selectedVaccineIds).filter(([, v]) => v).map(([k]) => Number(k))
    if (cowIds.length === 0 || vaccineIds.length === 0) return
    setSubmitting(true)
    try {
      const res = await bulkVaccinate({ cow_ids: cowIds, vaccine_ids: vaccineIds, event_date: eventDate, notes: notes.trim() || undefined })
      addToast({ title: 'Vaccinations recorded', description: `${res.inserted} inserted, ${res.skipped_duplicates} skipped`, type: 'success' })
      setSelectedCowIds({})
      setSelectedVaccineIds({})
    } catch (e) {
      addToast({ title: 'Failed to record vaccinations', description: e instanceof Error ? e.message : String(e), type: 'error' })
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="space-y-4">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <CardTitle className="text-base">Due soon</CardTitle>
            <div className="flex items-center gap-2">
              <label className="text-sm text-slate-600">Within (days)</label>
              <input className="border rounded-md px-2 py-1 h-9 w-24" inputMode="numeric" value={withinDays} onChange={(e) => setWithinDays(e.target.value)} />
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          {isLoading ? (
            <p className="p-3 text-sm text-slate-600">Loading…</p>
          ) : due.length === 0 ? (
            <p className="p-3 text-sm text-slate-600">Nothing due in the selected window.</p>
          ) : (
            <ScrollablePanel maxHeight={360}>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Cow</TableHead>
                    <TableHead>Vaccine</TableHead>
                    <TableHead>Next due</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {due.map((d) => {
                    const cow = cows.find((c) => c.id === d.cow_id)
                    const vaccine = vaccines.find((v) => v.id === d.vaccine_id)
                    return (
                      <TableRow key={`${d.cow_id}-${d.vaccine_id}`}>
                        <TableCell>{cow ? cow.external_id : `Cow ${d.cow_id}`}</TableCell>
                        <TableCell>{vaccine ? vaccine.name : `Vaccine ${d.vaccine_id}`}</TableCell>
                        <TableCell>{d.next_due_date}</TableCell>
                      </TableRow>
                    )
                  })}
                </TableBody>
              </Table>
            </ScrollablePanel>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Bulk vaccinate</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <div className="flex items-center justify-between">
                <div className="text-sm font-medium">Vaccines</div>
                <label className="text-xs inline-flex items-center gap-1">
                  <input
                    type="checkbox"
                    checked={vaccines.length > 0 && vaccines.every((v) => selectedVaccineIds[v.id])}
                    onChange={(e) => {
                      const checked = e.target.checked
                      const next: Record<number, boolean> = {}
                      for (const v of vaccines) next[v.id] = checked
                      setSelectedVaccineIds(next)
                    }}
                  />
                  <span>Select all</span>
                </label>
              </div>
              <div className="mt-2 max-h-64 overflow-auto space-y-2 pr-1">
                {vaccines.map((v) => (
                  <label key={v.id} className="flex items-center gap-2 text-sm">
                    <input
                      type="checkbox"
                      checked={!!selectedVaccineIds[v.id]}
                      onChange={(e) => setSelectedVaccineIds((prev) => ({ ...prev, [v.id]: e.target.checked }))}
                    />
                    <span>{v.name} <span className="text-xs text-slate-500">({v.recurrence_days}d)</span></span>
                  </label>
                ))}
              </div>
            </div>
            <div>
              <div className="flex items-center justify-between">
                <div className="text-sm font-medium">Cows {currentCycle?.id ? `(Cycle ${currentCycle.id})` : ''}</div>
                <label className="text-xs inline-flex items-center gap-1">
                  <input
                    type="checkbox"
                    checked={cows.length > 0 && cows.every((c) => selectedCowIds[c.id])}
                    onChange={(e) => {
                      const checked = e.target.checked
                      const next: Record<number, boolean> = {}
                      for (const c of cows) next[c.id] = checked
                      setSelectedCowIds(next)
                    }}
                  />
                  <span>Select all</span>
                </label>
              </div>
              <div className="mt-2 max-h-64 overflow-auto space-y-2 pr-1">
                {cows.map((c) => (
                  <label key={c.id} className="flex items-center gap-2 text-sm">
                    <input
                      type="checkbox"
                      checked={!!selectedCowIds[c.id]}
                      onChange={(e) => setSelectedCowIds((prev) => ({ ...prev, [c.id]: e.target.checked }))}
                    />
                    <span>{c.external_id}</span>
                  </label>
                ))}
              </div>
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <input className="border rounded-md px-3 py-2" type="date" value={eventDate} onChange={(e) => setEventDate(e.target.value)} />
            <input className="border rounded-md px-3 py-2 md:col-span-2" placeholder="Notes (optional)" value={notes} onChange={(e) => setNotes(e.target.value)} />
          </div>
          <div className="flex items-center justify-end gap-2">
            <button className="rounded border px-3 py-1" onClick={() => { setSelectedCowIds({}); setSelectedVaccineIds({}); setNotes('') }}>Clear</button>
            <button
              className="rounded bg-blue-600 text-white px-3 py-1 disabled:opacity-50"
              disabled={submitting || Object.values(selectedCowIds).every((v) => !v) || Object.values(selectedVaccineIds).every((v) => !v)}
              onClick={handleBulkApply}
            >
              {submitting ? 'Saving…' : 'Apply vaccinations'}
            </button>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Recent vaccination records</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {recordsLoading ? (
            <p className="p-3 text-sm text-slate-600">Loading…</p>
          ) : vaccinations.length === 0 ? (
            <p className="p-3 text-sm text-slate-600">No records yet.</p>
          ) : (
            <ScrollablePanel maxHeight={360}>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Date</TableHead>
                    <TableHead>Cow</TableHead>
                    <TableHead>Vaccine</TableHead>
                    <TableHead>Notes</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {vaccinations.map((ve) => {
                    const cow = cows.find((c) => c.id === ve.cow_id)
                    const vaccine = vaccines.find((v) => v.id === ve.vaccine_id)
                    return (
                      <TableRow key={ve.id}>
                        <TableCell>{ve.event_date}</TableCell>
                        <TableCell>{cow ? cow.external_id : `Cow ${ve.cow_id}`}</TableCell>
                        <TableCell>{vaccine ? vaccine.name : `Vaccine ${ve.vaccine_id}`}</TableCell>
                        <TableCell>{ve.notes || ''}</TableCell>
                      </TableRow>
                    )
                  })}
                </TableBody>
              </Table>
            </ScrollablePanel>
          )}
        </CardContent>
      </Card>
    </div>
  )
}

// Records view consolidated into Due tab; separate RecordsTab removed to simplify UI


