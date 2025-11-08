import { useEffect, useMemo, useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Badge } from '../components/ui/badge'
import Button from '../components/ui/button'
import { Calendar, Weight as WeightIcon, DollarSign, ArrowLeft, ArrowRight } from 'lucide-react'
import { ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid } from 'recharts'
import { useWeighEvents } from '../hooks/weighs'
import { apiGet } from '../lib/api'
import type { Cow as CowType } from '../hooks/cows'
import { useSales } from '../hooks/sales'
import { useCurrentCycle } from '../hooks/cycles'
import { formatHumanDate, formatMonthDay } from '../lib/utils'

export default function Cow({ id }: { id: number }) {
  const [cow, setCow] = useState<CowType | null>(null)
  const [isLoadingCow, setIsLoadingCow] = useState(true)
  const [errorCow, setErrorCow] = useState<string | null>(null)

  const { data: events = [], isLoading: isLoadingEvents } = useWeighEvents(id)
  const { data: sales = [] } = useSales(useCurrentCycle().data?.id)
  const sale = useMemo(() => sales.find((s) => s.cow_id === id), [sales, id])

  const current = useCurrentCycle()
  useEffect(() => {
    let mounted = true
    async function load() {
      setIsLoadingCow(true)
      try {
        const row = await apiGet<CowType>(`/api/cows/${id}`)
        if (!mounted) return
        setCow(row)
        setErrorCow(null)
      } catch (_e) {
        try {
          const cycleId = current.data?.id
          if (!cycleId) throw new Error('cycle not ready')
          const rows = await apiGet<CowType[]>(`/api/cows?cycle_id=${cycleId}`)
          const found = rows.find((r: any) => Number(r.id) === Number(id)) || null
          if (!mounted) return
          if (found) {
            setCow(found)
            setErrorCow(null)
          } else {
            setErrorCow('Cow not found')
          }
        } catch (e2: any) {
          if (!mounted) return
          setErrorCow('Failed to load cow')
        }
      } finally {
        if (mounted) setIsLoadingCow(false)
      }
    }
    load()
    return () => { mounted = false }
  }, [id, current.data?.id])

  const points = useMemo(() => {
    const sorted = [...events].sort((a, b) => a.weighed_at.localeCompare(b.weighed_at))
    return sorted.map((e) => ({
      date: e.weighed_at,
      weight: Number(e.weight_kg),
      t: new Date(e.weighed_at).getTime(),
    }))
  }, [events])

  const [selectedIndex, setSelectedIndex] = useState<number>(points.length ? points.length - 1 : 0)
  useEffect(() => { setSelectedIndex(points.length ? points.length - 1 : 0) }, [points.length])

  const active = points[selectedIndex]

  // scale removed (background cow removed per updated design)

  // Meta stats
  const startWeight = points.length ? points[0].weight : null
  const gainToDate = active && startWeight != null ? (active.weight - startWeight) : null
  const daysOnFarm = useMemo(() => {
    if (!cow?.purchase_date || !active) return null
    const a = new Date(cow.purchase_date).getTime()
    const b = active.t
    return Math.max(1, Math.round((b - a) / (1000 * 60 * 60 * 24)))
  }, [cow?.purchase_date, active])
  const avgDailyGain = gainToDate != null && daysOnFarm ? (gainToDate / daysOnFarm) : null

  const [hoverXY, setHoverXY] = useState<{ x: number; y: number } | null>(null)

  function handleChartMouseMove(state: any) {
    if (!state) return
    if (typeof state.activeTooltipIndex === 'number') {
      setSelectedIndex(state.activeTooltipIndex)
    }
    if (typeof state.chartX === 'number' && typeof state.chartY === 'number') {
      setHoverXY({ x: state.chartX, y: state.chartY })
    }
  }

  return (
    <div className="space-y-4">
      {/* Header */}
      <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-3">
        <div>
          <h1 className="page-title">Cow {cow?.external_id ?? `#${id}`}</h1>
          <p className="muted">{cow?.breed ?? ''}</p>
        </div>
        <Badge variant={cow?.status === 'sold' ? 'default' : 'secondary'} className="capitalize">{cow?.status ?? 'active'}</Badge>
      </div>

      {/* Top Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card>
          <CardHeader className="pb-2"><CardTitle className="text-base flex items-center gap-2"><Calendar className="w-4 h-4"/> Purchased</CardTitle></CardHeader>
          <CardContent className="text-sm">
            <div className="flex items-center justify-between">
              <span>{cow?.purchase_date ? formatHumanDate(cow.purchase_date) : '—'}</span>
              <span className="font-medium">{cow?.purchase_price != null ? `${cow.purchase_price} ${cow?.purchase_currency_code ?? 'EGP'}` : '—'}</span>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2"><CardTitle className="text-base flex items-center gap-2"><WeightIcon className="w-4 h-4"/> Current</CardTitle></CardHeader>
          <CardContent className="text-sm">
            <div className="flex items-center justify-between">
              <span>{active ? formatHumanDate(active.date) : '—'}</span>
              <span className="font-medium">{active ? `${active.weight} kg` : '—'}</span>
            </div>
            <div className="my-3 h-px bg-slate-200 dark:bg-slate-800" />
            <div className="flex items-center justify-between text-xs opacity-80"><span>Days on farm</span><span>{daysOnFarm ?? '—'}</span></div>
            <div className="flex items-center justify-between text-xs opacity-80"><span>Avg daily gain</span><span>{avgDailyGain != null ? `${avgDailyGain.toFixed(2)} kg/day` : '—'}</span></div>
          </CardContent>
        </Card>
        {sale ? (
          <Card>
            <CardHeader className="pb-2"><CardTitle className="text-base flex items-center gap-2"><DollarSign className="w-4 h-4"/> Sold</CardTitle></CardHeader>
            <CardContent className="text-sm">
              <div className="flex items-center justify-between">
                <span>{new Date(sale.date_sold).toLocaleDateString()}</span>
                <span className="font-medium">{sale.price_per_kg} {sale.currency_code}/kg</span>
              </div>
            </CardContent>
          </Card>
        ) : (
          <div className="hidden md:block" />
        )}
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Growth Timeline</CardTitle>
        </CardHeader>
        <CardContent>
          {isLoadingCow || isLoadingEvents ? (
            <div className="p-6 text-sm text-slate-500">Loading…</div>
          ) : points.length === 0 ? (
            <div className="p-6 text-sm text-slate-500">No weigh events yet</div>
          ) : (
            <div className="relative" onMouseLeave={() => setSelectedIndex(points.length - 1)}>
              {/* Background removed per design */}

              {/* Chart overlay (Recharts) */}
              <div className="relative z-[1] h-[320px]">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={points} margin={{ top: 24, right: 24, left: 16, bottom: 64 }} onMouseMove={handleChartMouseMove as any} onMouseLeave={() => setHoverXY(null)}>
                    <defs>
                      <linearGradient id="lineGrad" x1="0" x2="0" y1="0" y2="1">
                        <stop offset="0%" stopColor="#2563eb" stopOpacity={0.95} />
                        <stop offset="100%" stopColor="#2563eb" stopOpacity={0.25} />
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" opacity={0.25} />
                    <XAxis dataKey="date" tickFormatter={(d: string) => formatMonthDay(d)} tick={{ fontSize: 12, fill: 'currentColor', opacity: 0.8 }} />
                    <YAxis dataKey="weight" tick={{ fontSize: 12, fill: 'currentColor', opacity: 0.8 }} width={40} />
                    {/* Removed built-in tooltip; we use a custom anchored tooltip with since-prev delta */}
                    <Line type="monotone" dataKey="weight" stroke="url(#lineGrad)" strokeWidth={3}
                      dot={(props: any) => {
                        const { cx, cy, index: i } = props
                        const isActive = i === selectedIndex
                        return (
                          // eslint-disable-next-line jsx-a11y/no-static-element-interactions
                          <g onClick={() => setSelectedIndex(i)} style={{ cursor: 'pointer' }}>
                            <circle cx={cx} cy={cy} r={isActive ? 7 : 4} fill={isActive ? '#2563eb' : '#94a3b8'} />
                            {isActive ? (<circle cx={cx} cy={cy} r={12} fill="none" stroke="#2563eb" strokeOpacity={0.25} strokeWidth={8} />) : null}
                          </g>
                        )
                      }}
                      activeDot={{ r: 8 }}
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>

              {/* Tooltip anchored near the active point */}
              {active && hoverXY ? (
                <div
                  className="absolute z-[2] rounded border bg-white/90 dark:bg-slate-900/80 backdrop-blur px-2 py-1 text-xs shadow-sm"
                  style={{ left: hoverXY.x, top: hoverXY.y - 8, transform: 'translate(-50%, -100%)' }}
                >
                  <div>{formatHumanDate(active.date)}</div>
                  <div className="font-semibold">{active.weight} kg</div>
                  <div className="text-slate-500">
                    {selectedIndex > 0 ? `${(active.weight - points[selectedIndex - 1].weight).toFixed(1)} kg since prev` : ''}
                  </div>
                </div>
              ) : null}
              {/* Controls centered */}
              <div className="absolute left-0 right-0 bottom-6 flex items-center justify-center gap-2">
                <Button variant="outline" onClick={() => setSelectedIndex((i) => Math.max(0, i - 1))}><ArrowLeft className="w-4 h-4"/></Button>
                <Button variant="outline" onClick={() => setSelectedIndex((i) => Math.min(points.length - 1, i + 1))}><ArrowRight className="w-4 h-4"/></Button>
              </div>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Bottom meta */}
      <div className="grid grid-cols-2 md:grid-cols-3 gap-4 text-sm">
        <Card>
          <CardHeader><CardTitle className="text-base">Start Weight</CardTitle></CardHeader>
          <CardContent><div className="font-medium">{startWeight != null ? `${startWeight} kg` : '—'}</div></CardContent>
        </Card>
        <Card>
          <CardHeader><CardTitle className="text-base">Gain to Date</CardTitle></CardHeader>
          <CardContent><div className="font-medium">{gainToDate != null ? `${gainToDate.toFixed(1)} kg` : '—'}</div></CardContent>
        </Card>
        <Card>
          <CardHeader><CardTitle className="text-base">Notes</CardTitle></CardHeader>
          <CardContent><div className="opacity-90">{cow?.notes ?? '—'}</div></CardContent>
        </Card>
      </div>

      {errorCow ? <div className="text-sm text-red-600">{errorCow}</div> : null}
    </div>
  )
}
// Removed Recharts Tooltip renderer; using a custom anchored tooltip above the active point

