import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'

export default function Finance() {
  const [revenue, setRevenue] = useState<number | null>(null)
  const [expenses, setExpenses] = useState<number | null>(null)

  useEffect(() => {
    async function load() {
      const cycleId = Number(localStorage.getItem('currentCycleId') || 0) || 0
      const { data: sales } = await supabase.from('sale').select('price_per_kg, weight_at_sale_kg').eq('cow->>cycle_id', String(cycleId))
      // fallback: query by cow.cycle_id join
      const revenueTotal = (sales ?? []).reduce((acc: any, s: any) => acc + (Number(s.price_per_kg) * Number(s.weight_at_sale_kg || 0)), 0)
      setRevenue(revenueTotal)

      const { data: ex } = await supabase.from('expense').select('amount').eq('cycle_id', cycleId)
      const expenseTotal = (ex ?? []).reduce((acc: any, e: any) => acc + Number(e.amount || 0), 0)
      setExpenses(expenseTotal)
    }
    load()
  }, [])

  const profit = (revenue ?? 0) - (expenses ?? 0)

  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Finance</h1>
      <div className="grid grid-cols-3 gap-4">
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Revenue</div>
          <div className="text-2xl font-bold">EGP {revenue ?? '0'}</div>
        </div>
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Expenses</div>
          <div className="text-2xl font-bold">EGP {expenses ?? '0'}</div>
        </div>
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Profit</div>
          <div className="text-2xl font-bold">EGP {profit}</div>
        </div>
      </div>
    </div>
  )
}


