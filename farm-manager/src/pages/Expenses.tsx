import { useMemo, useState } from 'react'
import { useExpenseCategories, useExpenses, useCreateExpense, useCreateExpenseCategory } from '../hooks/expenses'
import { useCurrentCycle } from '../hooks/cycles'
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/Card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table'
import Button from '../components/ui/button'
import { Badge } from '../components/ui/badge'

export default function Expenses() {
  const { data: categories = [], isLoading: catsLoading, refetch: refetchCats } = useExpenseCategories()
  const { data: expenses = [], isLoading, refetch } = useExpenses()
  const creator = useCreateExpense()
  const catCreator = useCreateExpenseCategory()
  const current = useCurrentCycle()

  const [catId, setCatId] = useState<number | ''>('')
  const [date, setDate] = useState<string>(() => new Date().toISOString().slice(0, 10))
  const [amount, setAmount] = useState('')
  const [desc, setDesc] = useState('')
  const [creating, setCreating] = useState(false)

  const [newCatName, setNewCatName] = useState('')
  const [newCatDesc, setNewCatDesc] = useState('')
  const [creatingCat, setCreatingCat] = useState(false)
  const [createCatError, setCreateCatError] = useState<string | null>(null)

  const [filterCatId, setFilterCatId] = useState<number | ''>('')

  const filteredExpenses = useMemo(() => {
    if (!filterCatId) return expenses
    return expenses.filter((e: any) => Number(e.expense_category_id) === Number(filterCatId))
  }, [expenses, filterCatId])

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault()
    if (!catId || !date || !amount) return
    const cycleId = Number(current.data?.id || 0) || 0
    if (!cycleId) return
    setCreating(true)
    await creator.create({ cycle_id: cycleId, expense_category_id: Number(catId), expense_date: date, amount: Number(amount), description: desc })
    setCreating(false)
    setCatId('')
    setDate(new Date().toISOString().slice(0, 10))
    setAmount('')
    setDesc('')
    await refetch()
  }

  async function handleCreateCategory(e: React.FormEvent) {
    e.preventDefault()
    const name = newCatName.trim()
    if (!name) {
      setCreateCatError('Name is required')
      return
    }
    setCreatingCat(true)
    setCreateCatError(null)
    try {
      const { data, error } = await catCreator.create({ name, description: newCatDesc.trim() || undefined })
      if (error) throw error
      setNewCatName('')
      setNewCatDesc('')
      await refetchCats()
      if (data?.id) setCatId(data.id)
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to create category'
      setCreateCatError(message)
    } finally {
      setCreatingCat(false)
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold">Expenses</h1>
          <p className="text-sm text-slate-600">Create expense categories and record expenses for the current cycle.</p>
        </div>
        <button className="rounded border px-3 py-1" onClick={() => { refetch(); refetchCats() }}>Refresh</button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Expense categories</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <form onSubmit={handleCreateCategory} className="grid grid-cols-1 gap-3">
              <input
                className="border rounded-md px-3 py-2"
                placeholder="Name"
                value={newCatName}
                onChange={(e) => setNewCatName(e.target.value)}
              />
              <input
                className="border rounded-md px-3 py-2"
                placeholder="Description (optional)"
                value={newCatDesc}
                onChange={(e) => setNewCatDesc(e.target.value)}
              />
              {createCatError && <p className="text-sm text-red-600">{createCatError}</p>}
              <div className="flex justify-end">
                <Button type="submit" disabled={creatingCat}>{creatingCat ? 'Saving…' : 'Add Category'}</Button>
              </div>
            </form>
            <div>
              <p className="text-xs text-slate-500 mb-2">Existing categories</p>
              {catsLoading ? (
                <p className="text-sm text-slate-500">Loading…</p>
              ) : (categories || []).length === 0 ? (
                <p className="text-sm text-slate-500">No categories yet.</p>
              ) : (
                <div className="flex flex-wrap gap-2">
                  {(categories || []).map((c) => (
                    <Badge key={c.id} variant="outline">{c.name}</Badge>
                  ))}
                </div>
              )}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Record expense</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleCreate} className="grid grid-cols-1 gap-3">
              <select
                className="border rounded-md px-3 py-2"
                value={String(catId)}
                onChange={(e) => setCatId(e.target.value === '' ? '' : Number(e.target.value))}
              >
                <option value="">Category</option>
                {(categories || []).map((c) => (
                  <option key={c.id} value={c.id}>{c.name}</option>
                ))}
              </select>
              <div className="grid grid-cols-2 gap-3">
                <input
                  type="date"
                  className="border rounded-md px-3 py-2"
                  value={date}
                  onChange={(e) => setDate(e.target.value)}
                />
                <input
                  className="border rounded-md px-3 py-2"
                  placeholder="Amount"
                  inputMode="decimal"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                />
              </div>
              <input
                className="border rounded-md px-3 py-2"
                placeholder="Description (optional)"
                value={desc}
                onChange={(e) => setDesc(e.target.value)}
              />
              <div className="flex justify-end">
                <Button disabled={!current.data?.id || !catId || !date || !amount || creating}>{creating ? 'Saving…' : 'Add Expense'}</Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <div className="flex items-center justify-between gap-2">
            <CardTitle className="text-base">Recent expenses</CardTitle>
            <div className="flex items-center gap-2">
              <select
                className="border rounded-md px-2 py-1 h-9"
                value={String(filterCatId)}
                onChange={(e) => setFilterCatId(e.target.value === '' ? '' : Number(e.target.value))}
              >
                <option value="">All categories</option>
                {(categories || []).map((c) => (
                  <option key={c.id} value={c.id}>{c.name}</option>
                ))}
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Date</TableHead>
                <TableHead>Category</TableHead>
                <TableHead>Description</TableHead>
                <TableHead className="text-right">Amount</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-slate-500">Loading…</TableCell>
                </TableRow>
              ) : filteredExpenses.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-slate-500">No expenses yet</TableCell>
                </TableRow>
              ) : (
                filteredExpenses.map((ex: any) => {
                  const cat = (categories || []).find((c) => c.id === ex.expense_category_id)
                  return (
                    <TableRow key={ex.id}>
                      <TableCell>{ex.expense_date}</TableCell>
                      <TableCell>{cat?.name ?? ex.expense_category_id}</TableCell>
                      <TableCell>{ex.description || ''}</TableCell>
                      <TableCell className="text-right">{ex.currency_code} {Number(ex.amount).toLocaleString()}</TableCell>
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


