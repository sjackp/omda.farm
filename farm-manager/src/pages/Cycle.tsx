import type { FormEvent } from 'react'
import { useState } from 'react'
import { useCurrentCycle, useCycles, useSetCurrentCycle } from '../hooks/cycles'
import { apiPost } from '../lib/api'

export default function Cycle() {
  const { data: cycles, refetch } = useCycles()
  const { data: current } = useCurrentCycle()
  const setCurrent = useSetCurrentCycle()

  const [name, setName] = useState('')
  const [startDate, setStartDate] = useState('')
  const [isCreating, setCreating] = useState(false)

  async function handleCreate(e: FormEvent) {
    e.preventDefault()
    if (!name || !startDate) return
    setCreating(true)
    try {
      await apiPost('/api/cycles', { name, start_date: startDate })
      setName('')
      setStartDate('')
      await refetch()
    } catch (e) {
      // eslint-disable-next-line no-console
      console.error(e)
    } finally {
      setCreating(false)
    }
  }

  return (
    <div className="space-y-4">
      <h1 className="text-xl font-semibold">Cycles</h1>

      <form onSubmit={handleCreate} className="flex items-center gap-2">
        <input className="border rounded px-2 py-1" placeholder="Name" value={name} onChange={(e) => setName(e.target.value)} />
        <input type="date" className="border rounded px-2 py-1" value={startDate} onChange={(e) => setStartDate(e.target.value)} />
        <button className="rounded bg-blue-600 text-white px-3 py-1" disabled={isCreating}>{isCreating ? 'Creating...' : 'Create'}</button>
      </form>

      <div className="rounded border divide-y">
        {(cycles ?? []).map((c) => (
          <div key={c.id} className="flex items-center gap-3 p-3">
            <div className="flex-1">
              <div className="font-medium">{c.name}</div>
              <div className="text-xs text-slate-500">Start: {c.start_date}{c.end_date ? ` · End: ${c.end_date}` : ''}</div>
            </div>
            {current?.id === c.id ? (
              <span className="text-xs rounded bg-green-100 text-green-800 dark:bg-green-900/40 dark:text-green-200 px-2 py-1">Current</span>
            ) : (
              <button className="text-sm rounded border px-2 py-1 hover:bg-slate-50 dark:hover:bg-slate-900" onClick={() => setCurrent.mutate(c.id)}>Set current</button>
            )}
          </div>
        ))}
      </div>
    </div>
  )
}


