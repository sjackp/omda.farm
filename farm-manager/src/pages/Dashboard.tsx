import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Users, Wheat, Receipt, Wallet } from 'lucide-react'
import { Link } from 'wouter'
import { useVaccinesDue } from '../hooks/vaccines'
import { useCows } from '../hooks/cows'
import { useFeedOnHand } from '../hooks/feed'
import { useExpenses } from '../hooks/expenses'
import { useSales } from '../hooks/sales'
import { useMemo } from 'react'

function Stat({ title, value, icon }: { title: string; value: string; icon: React.ReactNode }) {
  return (
    <Card>
      <CardHeader className="flex items-center justify-between pb-2">
        <CardTitle className="text-sm text-slate-600 dark:text-slate-300">{title}</CardTitle>
        <div className="text-blue-600">{icon}</div>
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        <div className="text-xs text-slate-500">Updated just now</div>
      </CardContent>
    </Card>
  )
}

export default function Dashboard() {
  const { data: due = [], isLoading: dueLoading } = useVaccinesDue({ within_days: 7 })
  const { data: cows = [], isLoading: cowsLoading } = useCows()
  const { data: onHand = [], isLoading: onHandLoading } = useFeedOnHand()
  const { data: expenses = [], isLoading: exLoading } = useExpenses()
  const { data: sales = [], isLoading: salesLoading } = useSales()

  const now = new Date()
  const monthStart = new Date(now.getFullYear(), now.getMonth(), 1).toISOString().slice(0, 10)
  const monthEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0).toISOString().slice(0, 10)

  function withinMonth(dateStr: string): boolean {
    return dateStr >= monthStart && dateStr <= monthEnd
  }

  const kpis = useMemo(() => {
    const headcount = (cows || []).filter((c: any) => c.status === 'active').length
    const feedOnHand = (onHand || []).reduce((acc: number, row: any) => acc + Number(row.on_hand_kg || 0), 0)
    const mtdExpenses = (expenses || [])
      .filter((e: any) => withinMonth(e.expense_date))
      .reduce((acc: number, e: any) => acc + Number(e.amount || 0), 0)
    const mtdRevenue = (sales || [])
      .filter((s: any) => withinMonth(s.date_sold))
      .reduce((acc: number, s: any) => acc + (Number(s.price_per_kg) * Number(s.weight_at_sale_kg || 0)), 0)
    const mtdProfit = mtdRevenue - mtdExpenses
    return { headcount, feedOnHand, mtdExpenses, mtdProfit }
  }, [cows, onHand, expenses, sales])

  const loading = cowsLoading || onHandLoading || exLoading || salesLoading
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="page-title">Dashboard</h1>
          <p className="muted">Key metrics for the current cycle</p>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Stat title="Headcount" value={loading ? '—' : String(kpis.headcount)} icon={<Users className="h-5 w-5" />} />
        <Stat title="Feed on-hand (kg)" value={loading ? '—' : kpis.feedOnHand.toLocaleString()} icon={<Wheat className="h-5 w-5" />} />
        <Stat title="MTD Expenses" value={loading ? '—' : `EGP ${Math.round(kpis.mtdExpenses).toLocaleString()}`} icon={<Receipt className="h-5 w-5" />} />
        <Stat title="MTD Profit" value={loading ? '—' : `EGP ${Math.round(kpis.mtdProfit).toLocaleString()}`} icon={<Wallet className="h-5 w-5" />} />
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Vaccines due in 7 days</CardTitle>
        </CardHeader>
        <CardContent>
          {dueLoading ? (
            <div className="text-sm text-slate-500">Loading…</div>
          ) : (
            <div className="flex items-center justify-between">
              <div className="text-sm">
                {due.length === 0 ? 'Nothing due soon.' : `${due.length} item(s) due soon.`}
              </div>
              <Link href="/vaccines" className="text-blue-600 text-sm hover:underline">
                Review
              </Link>
            </div>
          )}
        </CardContent>
      </Card>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Recent Activity</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-sm text-slate-500">No recent records. Start by adding cows, feed, or expenses.</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Inventory On-hand</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-sm text-slate-500">No inventory yet. Receive supply to populate this section.</div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}


