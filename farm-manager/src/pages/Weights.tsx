import { useState, useEffect } from 'react'
import { useWeighEvents, useRecordWeighEvent } from '../hooks/weighs'
import { useCows } from '../hooks/cows'

export default function Weights() {
  const { data: events = [], isLoading, refetch } = useWeighEvents()
  const { data: cows = [] } = useCows()
  const recorder = useRecordWeighEvent()

  const [cowId, setCowId] = useState<number | ''>('')
  const [weight, setWeight] = useState('')
  const [weighedAt, setWeighedAt] = useState('')
  const [notes, setNotes] = useState('')

  useEffect(() => {
    const today = new Date().toISOString().slice(0, 10)
    setWeighedAt(today)
  }, [])

  async function handleRecord(e: React.FormEvent) {
    e.preventDefault()
    if (!cowId || !weight) return
    await recorder.create({ cow_id: Number(cowId), weight_kg: Number(weight), weighed_at: weighedAt, notes })
    setWeight('')
    setNotes('')
    setCowId('')
    await refetch()
  }

  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Weights</h1>

      <form onSubmit={handleRecord} className="flex gap-2 items-center mb-4">
        <select className="border rounded px-2 py-1" value={String(cowId)} onChange={(e) => setCowId(e.target.value === '' ? '' : Number(e.target.value))}>
          <option value="">Select cow</option>
          {cows.map(c => <option key={c.id} value={c.id}>{c.external_id}</option>)}
        </select>
        <input className="border rounded px-2 py-1" placeholder="Weight (kg)" value={weight} onChange={(e) => setWeight(e.target.value)} />
        <input type="date" className="border rounded px-2 py-1" value={weighedAt} onChange={(e) => setWeighedAt(e.target.value)} />
        <input className="border rounded px-2 py-1" placeholder="Notes" value={notes} onChange={(e) => setNotes(e.target.value)} />
        <button className="rounded bg-[#6B7A3A] hover:bg-[#5F6D3A] text-white px-3 py-1">Record</button>
      </form>

      <div className="rounded border">
        {isLoading ? (
          <div className="p-4">Loading...</div>
        ) : events.length === 0 ? (
          <div className="p-4">No weight events yet</div>
        ) : (
          events.map((ev: any) => (
            <div key={ev.id} className="flex items-center justify-between p-3 border-b last:border-b-0">
              <div>
                <div className="font-medium">{(cows.find(c => c.id === ev.cow_id)?.external_id) ?? `Cow ${ev.cow_id}`}</div>
                <div className="text-xs text-slate-500">{ev.weighed_at}</div>
              </div>
              <div className="text-sm">{ev.weight_kg} kg</div>
            </div>
          ))
        )}
      </div>
    </div>
  )
}


