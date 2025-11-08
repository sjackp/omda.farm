import { useMemo } from 'react'
import { useSales } from '../hooks/sales'
import { useExpenses } from '../hooks/expenses'
import { formatHumanDate } from '../lib/utils'

export default function Finance() {
  const { data: sales = [], isLoading: salesLoading } = useSales()
  const { data: expenses = [], isLoading: expensesLoading } = useExpenses()

  const totals = useMemo(() => {
    const revenue = (sales || []).reduce((acc, s: any) => acc + (Number(s.price_per_kg) * Number(s.weight_at_sale_kg || 0)), 0)
    const expenseTotal = (expenses || []).reduce((acc, e: any) => acc + Number(e.amount || 0), 0)
    const profit = revenue - expenseTotal
    return { revenue, expenseTotal, profit }
  }, [sales, expenses])

  const loading = salesLoading || expensesLoading

  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Finance</h1>
      <div className="grid grid-cols-3 gap-4">
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Revenue</div>
          <div className="text-2xl font-bold">{loading ? '—' : `EGP ${Math.round(totals.revenue).toLocaleString()}`}</div>
        </div>
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Expenses</div>
          <div className="text-2xl font-bold">{loading ? '—' : `EGP ${Math.round(totals.expenseTotal).toLocaleString()}`}</div>
        </div>
        <div className="rounded border p-4">
          <div className="text-sm text-slate-500">Profit</div>
          <div className="text-2xl font-bold">{loading ? '—' : `EGP ${Math.round(totals.profit).toLocaleString()}`}</div>
        </div>
      </div>

      <div className="mt-6 grid grid-cols-1 lg:grid-cols-2 gap-4">
        <div className="rounded border">
          <div className="px-4 py-3 border-b font-medium">Recent Sales</div>
          <div className="p-3 text-sm">
            {(sales || []).slice(0, 8).map((s: any) => {
              const total = Number(s.price_per_kg) * Number(s.weight_at_sale_kg)
              return (
                <div key={s.id} className="flex items-center justify-between py-1.5">
                  <div className="opacity-80">{formatHumanDate(s.date_sold)}</div>
                  <div className="opacity-80">{s.cow?.external_id ?? s.cow_id}</div>
                  <div className="opacity-80">{(Number(s.weight_at_sale_kg)).toLocaleString()} kg</div>
                  <div className="font-medium">EGP {Math.round(total).toLocaleString()}</div>
                </div>
              )
            })}
            {(sales || []).length === 0 ? <div className="opacity-70">No sales yet.</div> : null}
          </div>
        </div>
        <div className="rounded border">
          <div className="px-4 py-3 border-b font-medium">Recent Expenses</div>
          <div className="p-3 text-sm">
            {(expenses || []).slice(0, 8).map((e: any) => (
              <div key={e.id} className="flex items-center justify-between py-1.5">
                <div className="opacity-80">{formatHumanDate(e.expense_date)}</div>
                <div className="opacity-80">{e.description || ''}</div>
                <div className="font-medium">{e.currency_code} {Math.round(Number(e.amount)).toLocaleString()}</div>
              </div>
            ))}
            {(expenses || []).length === 0 ? <div className="opacity-70">No expenses yet.</div> : null}
          </div>
        </div>
      </div>
    </div>
  )
}


