import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Users, Wheat, Receipt, Wallet } from 'lucide-react'
import { Link } from 'wouter'
import { useVaccinesDue } from '../hooks/vaccines'

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
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="page-title">Dashboard</h1>
          <p className="muted">Key metrics for the current cycle</p>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Stat title="Headcount" value="0" icon={<Users className="h-5 w-5" />} />
        <Stat title="Feed on-hand (kg)" value="0" icon={<Wheat className="h-5 w-5" />} />
        <Stat title="MTD Expenses" value="EGP 0" icon={<Receipt className="h-5 w-5" />} />
        <Stat title="MTD Profit" value="EGP 0" icon={<Wallet className="h-5 w-5" />} />
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


