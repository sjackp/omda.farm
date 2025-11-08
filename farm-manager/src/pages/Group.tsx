import { useMemo } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { useGroups } from '../hooks/groups'
import { useCows } from '../hooks/cows'
import { useFeedMovements, useFoodItems } from '../hooks/feed'
import { formatHumanDate } from '../lib/utils'
import { Link } from 'wouter'

export default function Group({ id }: { id: number }) {
  const { data: groups = [] } = useGroups()
  const { data: cows = [] } = useCows()
  const { data: movements = [] } = useFeedMovements()
  const { data: items = [] } = useFoodItems()

  const group = useMemo(() => groups.find((g: any) => Number(g.id) === Number(id)) || null, [groups, id])

  const nameById = useMemo(() => {
    const map: Record<number, string> = {}
    for (const it of (items || [])) map[Number(it.id)] = it.name
    return map
  }, [items])

  const memberCows = useMemo(() => {
    return (cows || []).filter((c: any) => Number(c.current_group_id) === Number(id))
  }, [cows, id])

  const groupUsage = useMemo(() => {
    const rows = (movements || [])
      .filter((m: any) => String(m.movement_type).toUpperCase() === 'USAGE' && String(m.usage_target_type).toLowerCase() === 'group' && Number(m.group_id) === Number(id))
      .sort((a: any, b: any) => new Date(b.movement_date).getTime() - new Date(a.movement_date).getTime())
    const totalConsumedKg = rows.reduce((acc: number, m: any) => acc + Math.abs(Number(m.qty_kg) || 0), 0)
    return { rows, totalConsumedKg }
  }, [movements, id])

  const usageByFeed = useMemo(() => {
    const sums = new Map<number, number>()
    for (const r of groupUsage.rows) {
      const fid = Number(r.food_item_id)
      const q = Math.abs(Number(r.qty_kg) || 0)
      sums.set(fid, (sums.get(fid) || 0) + q)
    }
    const out = Array.from(sums.entries()).map(([fid, qty]) => ({ food_item_id: fid, name: nameById[fid] ?? `Item ${fid}`, qty }))
    out.sort((a, b) => b.qty - a.qty)
    return out
  }, [groupUsage.rows, nameById])

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="page-title">Group #{group?.number ?? id}{group?.name ? ` — ${group.name}` : ''}</h1>
          <p className="muted">Overview and details</p>
        </div>
        <Link href="/groups" className="text-[#6B7A3A] hover:underline text-sm">Back to groups</Link>
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Summary</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-3 text-sm">
              <div className="rounded border p-3">
                <div className="text-xs text-slate-500">Status</div>
                <div className="text-lg font-semibold">{group?.active ? 'Active' : 'Inactive'}</div>
              </div>
              <div className="rounded border p-3">
                <div className="text-xs text-slate-500">Total cows</div>
                <div className="text-lg font-semibold">{memberCows.length}</div>
              </div>
              <div className="rounded border p-3 col-span-2">
                <div className="text-xs text-slate-500">Total feed consumed</div>
                <div className="text-lg font-semibold">{groupUsage.totalConsumedKg.toLocaleString()} kg</div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Consumption by feed</CardTitle>
          </CardHeader>
          <CardContent>
            {usageByFeed.length === 0 ? (
              <div className="text-sm text-slate-500">No recorded usage yet.</div>
            ) : (
              <div className="space-y-2">
                {usageByFeed.map((u) => (
                  <div key={u.food_item_id} className="flex items-center justify-between text-sm rounded border p-2">
                    <div className="truncate">{u.name}</div>
                    <div className="ml-2 text-slate-600">{u.qty.toLocaleString()} kg</div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Cows in this group</CardTitle>
        </CardHeader>
        <CardContent>
          {memberCows.length === 0 ? (
            <div className="text-sm text-slate-500">No cows currently assigned.</div>
          ) : (
            <div className="max-h-80 overflow-auto rounded border">
              <table className="w-full text-sm">
                <thead className="bg-slate-50 dark:bg-slate-900">
                  <tr>
                    <th className="text-left p-2">Cow</th>
                    <th className="text-left p-2">Breed</th>
                    <th className="text-right p-2">Latest weight</th>
                  </tr>
                </thead>
                <tbody>
                  {memberCows.map((c: any) => (
                    <tr key={c.id} className="border-t">
                      <td className="p-2">
                        <Link href={`/cow/${c.id}`} className="text-[#6B7A3A] hover:underline">
                          {c.external_id}
                        </Link>
                      </td>
                      <td className="p-2">{c.breed || '-'}</td>
                      <td className="p-2 text-right">{c.latest_weight_kg ? `${Number(c.latest_weight_kg)} kg` : '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Recent feed movements</CardTitle>
        </CardHeader>
        <CardContent>
          {groupUsage.rows.length === 0 ? (
            <div className="text-sm text-slate-500">No recent records.</div>
          ) : (
            <div className="max-h-80 overflow-auto space-y-2 pr-1">
              {groupUsage.rows.slice(0, 30).map((m: any) => (
                <div key={m.id} className="flex items-center justify-between text-sm">
                  <div className="truncate">
                    <span className="font-medium">{nameById[Number(m.food_item_id)] ?? `Item ${m.food_item_id}`}</span>
                    <span className="mx-2 text-slate-500">·</span>
                    <span className="uppercase">{String(m.movement_type).toUpperCase()}</span>
                  </div>
                  <div className="ml-2 flex items-center gap-3 text-xs text-slate-600">
                    <span>{Number(m.qty_kg)} kg</span>
                    <span>{formatHumanDate(m.movement_date)}</span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}


