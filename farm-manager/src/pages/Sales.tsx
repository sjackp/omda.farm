import { useEffect, useMemo, useState } from 'react'
import { useSales, useCreateSale } from '../hooks/sales'
import { useCows } from '../hooks/cows'
import { apiGet, apiPost } from '../lib/api'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'
import Button from '../components/ui/button'

type SaleLine = {
  id: string
  cowId: number | ''
  weight: string
  pricePerKg: string
  totalPrice: string
}

function newLine(): SaleLine {
  return { id: Math.random().toString(36).slice(2), cowId: '', weight: '', pricePerKg: '', totalPrice: '' }
}

export default function Sales() {
  const { data: sales = [], isLoading, refetch } = useSales()
  const { data: cows = [] } = useCows()
  const creator = useCreateSale()
  const [buyers, setBuyers] = useState<Array<{ id: number; name: string }>>([])

  const [buyerId, setBuyerId] = useState<number | ''>('')
  const [buyerName, setBuyerName] = useState('')
  const [dateSold, setDateSold] = useState<string>(() => new Date().toISOString().slice(0, 10))
  const [lines, setLines] = useState<SaleLine[]>([newLine()])
  const [submitting, setSubmitting] = useState(false)

  useEffect(() => {
    apiGet<Array<{ id: number; name: string }>>('/api/buyers').then((rows) => setBuyers(rows || []))
  }, [])

  async function ensureBuyer(name: string) {
    const existing = buyers.find((b) => b.name === name)
    if (existing) return existing.id
    try {
      const data = await apiPost<{ id: number; name: string }>('/api/buyers', { name })
      setBuyers((s) => [...s, data])
      return data.id
    } catch {
      return null
    }
  }

  const activeCows = useMemo(() => cows.filter((c: any) => c.status === 'active'), [cows])

  function setLine<K extends keyof SaleLine>(id: string, key: K, value: SaleLine[K]) {
    setLines((prev) => prev.map((ln) => (ln.id === id ? { ...ln, [key]: value } : ln)))
  }

  function onCowChange(id: string, cowId: number | '') {
    setLines((prev) =>
      prev.map((ln) => {
        if (ln.id !== id) return ln
        if (!cowId) return { ...ln, cowId: '', weight: '' }
        const cow = activeCows.find((c: any) => c.id === Number(cowId))
        const weight = cow?.latest_weight_kg ? String(cow.latest_weight_kg) : ''
        const pricePerKg = ln.pricePerKg
        const totalPrice = pricePerKg && weight ? String(Number(pricePerKg) * Number(weight)) : ln.totalPrice
        return { ...ln, cowId, weight, totalPrice }
      })
    )
  }

  function onWeightChange(id: string, weight: string) {
    setLines((prev) =>
      prev.map((ln) => {
        if (ln.id !== id) return ln
        const newWeight = weight
        if (newWeight && ln.pricePerKg) {
          return { ...ln, weight: newWeight, totalPrice: String(Number(newWeight) * Number(ln.pricePerKg)) }
        }
        if (newWeight && ln.totalPrice) {
          const w = Number(newWeight)
          return w > 0 ? { ...ln, weight: newWeight, pricePerKg: String(Number(ln.totalPrice) / w) } : { ...ln, weight: newWeight }
        }
        return { ...ln, weight: newWeight }
      })
    )
  }

  function onPricePerKgChange(id: string, ppk: string) {
    setLines((prev) =>
      prev.map((ln) => {
        if (ln.id !== id) return ln
        if (ppk && ln.weight) {
          return { ...ln, pricePerKg: ppk, totalPrice: String(Number(ppk) * Number(ln.weight)) }
        }
        return { ...ln, pricePerKg: ppk }
      })
    )
  }

  function onTotalChange(id: string, total: string) {
    setLines((prev) =>
      prev.map((ln) => {
        if (ln.id !== id) return ln
        const t = total
        if (t && ln.weight) {
          const w = Number(ln.weight)
          return w > 0 ? { ...ln, totalPrice: t, pricePerKg: String(Number(t) / w) } : { ...ln, totalPrice: t }
        }
        return { ...ln, totalPrice: t }
      })
    )
  }

  function addLine() {
    setLines((prev) => [...prev, newLine()])
  }

  function removeLine(id: string) {
    setLines((prev) => (prev.length > 1 ? prev.filter((ln) => ln.id !== id) : prev))
  }

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    if ((!buyerId && !buyerName) || !dateSold) return
    setSubmitting(true)
    let bId: number | '' = buyerId
    if (!bId) {
      bId = (await ensureBuyer(buyerName)) || ''
    }
    if (!bId) {
      setSubmitting(false)
      return
    }
    const payloads = lines
      .filter((ln) => ln.cowId && (ln.pricePerKg || ln.totalPrice) && ln.weight)
      .map((ln) => {
        const weightNum = Number(ln.weight)
        const ppk = ln.pricePerKg ? Number(ln.pricePerKg) : undefined
        const total = ln.totalPrice ? Number(ln.totalPrice) : undefined
        const pricePerKgNum = typeof ppk === 'number' && !Number.isNaN(ppk) ? ppk : (total && weightNum > 0 ? total / weightNum : 0)
        return {
          cow_id: Number(ln.cowId),
          buyer_id: Number(bId),
          date_sold: dateSold,
          weight_at_sale_kg: weightNum,
          price_per_kg: pricePerKgNum,
        }
      })
      .filter((p) => p.weight_at_sale_kg > 0 && p.price_per_kg > 0)

    for (const body of payloads) {
      await creator.create(body)
    }

    setBuyerId('')
    setBuyerName('')
    setDateSold(new Date().toISOString().slice(0, 10))
    setLines([newLine()])
    await refetch()
    setSubmitting(false)
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold">Sales</h1>
          <p className="text-sm text-slate-600">Record sales per cow, with auto-calculated totals.</p>
        </div>
        <button className="rounded border px-3 py-1" onClick={() => refetch()}>Refresh</button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Record Sale Order</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <form onSubmit={handleCreate} className="space-y-3">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
              <select
                className="border rounded-md px-3 py-2"
                value={String(buyerId)}
                onChange={(e) => setBuyerId(e.target.value === '' ? '' : Number(e.target.value))}
              >
                <option value="">Select buyer</option>
                {buyers.map((b) => (
                  <option key={b.id} value={b.id}>{b.name}</option>
                ))}
              </select>
              <input
                className="border rounded-md px-3 py-2"
                placeholder="Or new buyer"
                value={buyerName}
                onChange={(e) => setBuyerName(e.target.value)}
              />
              <input
                type="date"
                className="border rounded-md px-3 py-2"
                value={dateSold}
                onChange={(e) => setDateSold(e.target.value)}
              />
            </div>

            <div className="rounded border overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Cow</TableHead>
                    <TableHead className="text-right">Weight (kg)</TableHead>
                    <TableHead className="text-right">Price/kg</TableHead>
                    <TableHead className="text-right">Total</TableHead>
                    <TableHead className="text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {lines.map((ln) => (
                    <TableRow key={ln.id}>
                      <TableCell>
                        <select
                          className="border rounded-md px-2 py-1"
                          value={String(ln.cowId)}
                          onChange={(e) => onCowChange(ln.id, e.target.value === '' ? '' : Number(e.target.value))}
                        >
                          <option value="">Select cow</option>
                          {activeCows.map((c: any) => (
                            <option key={c.id} value={c.id}>{c.external_id}</option>
                          ))}
                        </select>
                      </TableCell>
                      <TableCell className="text-right">
                        <input
                          className="border rounded-md px-2 py-1 w-32 text-right"
                          placeholder="kg"
                          inputMode="decimal"
                          value={ln.weight}
                          onChange={(e) => onWeightChange(ln.id, e.target.value)}
                        />
                      </TableCell>
                      <TableCell className="text-right">
                        <input
                          className="border rounded-md px-2 py-1 w-32 text-right"
                          placeholder="EGP/kg"
                          inputMode="decimal"
                          value={ln.pricePerKg}
                          onChange={(e) => onPricePerKgChange(ln.id, e.target.value)}
                        />
                      </TableCell>
                      <TableCell className="text-right">
                        <input
                          className="border rounded-md px-2 py-1 w-32 text-right"
                          placeholder="EGP"
                          inputMode="decimal"
                          value={ln.totalPrice}
                          onChange={(e) => onTotalChange(ln.id, e.target.value)}
                        />
                      </TableCell>
                      <TableCell className="text-right">
                        <button type="button" className="text-sm rounded border px-2 py-1" onClick={() => removeLine(ln.id)}>Remove</button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>

            <div className="flex items-center justify-between">
              <Button type="button" onClick={addLine} variant="outline">Add Cow</Button>
              <Button type="submit" disabled={submitting || (!buyerId && !buyerName)}>
                {submitting ? 'Saving…' : 'Record Sales'}
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Recent Sales</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Date</TableHead>
                <TableHead>Buyer</TableHead>
                <TableHead>Cow</TableHead>
                <TableHead className="text-right">Weight (kg)</TableHead>
                <TableHead className="text-right">Price/kg</TableHead>
                <TableHead className="text-right">Total</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center text-slate-500">Loading…</TableCell>
                </TableRow>
              ) : sales.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center text-slate-500">No sales yet</TableCell>
                </TableRow>
              ) : (
                sales.map((s: any) => {
                  const total = Number(s.price_per_kg) * Number(s.weight_at_sale_kg)
                  return (
                    <TableRow key={s.id}>
                      <TableCell>{s.date_sold}</TableCell>
                      <TableCell>{s.buyer?.name ?? s.buyer_id}</TableCell>
                      <TableCell>{s.cow?.external_id ?? s.cow_id}</TableCell>
                      <TableCell className="text-right">{Number(s.weight_at_sale_kg).toLocaleString()}</TableCell>
                      <TableCell className="text-right">{s.currency_code} {Number(s.price_per_kg).toLocaleString()}</TableCell>
                      <TableCell className="text-right">{s.currency_code} {total.toLocaleString()}</TableCell>
                    </TableRow>
                  )
                })
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  )
}


