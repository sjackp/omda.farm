import express from 'express'
import dotenv from 'dotenv'
import path from 'path'
import fs from 'fs'
import cors from 'cors'
import { query } from './db.js'

// Load env in order: .env then .env.local (both server dir and repo root)
const cwd = process.cwd()
const parent = path.resolve(cwd, '..')
const envFiles = [cwd, parent]
  .flatMap((dir) => ['.env', '.env.local'].map((p) => path.resolve(dir, p)))
  .filter((p) => fs.existsSync(p))

for (const file of envFiles) {
  dotenv.config({ path: file, override: true })
}
console.log('Env files loaded:', envFiles.length ? envFiles.map((p) => path.basename(p)).join(', ') : 'none')

const app = express()
app.use(cors())
app.use(express.json())

app.post('/api/login', async (req, res) => {
  const { username, password } = req.body || {}
  if (!username || !password) return res.status(400).json({ error: 'username and password are required' })

  try {
    const { rows } = await query(
      `select id, username
         from public.app_user
        where username = $1
          and password_hash = crypt($2, password_hash)
        limit 1`,
      [username, password]
    )

    if (!rows.length) {
      return res.status(401).json({ error: 'Invalid credentials' })
    }

    const user = rows[0]
    res.json({ user: { id: Number(user.id), username: user.username } })
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Health: checks DB connectivity
app.get('/health', async (_req, res) => {
  try {
    const { rows } = await query('select 1 as ok')
    res.json({ ok: rows[0]?.ok === 1 })
  } catch (e) {
    res.status(500).json({ ok: false, error: String(e.message || e) })
  }
})

// Cycles (used by UI)
app.get('/api/cycles', async (_req, res) => {
  try {
    const { rows } = await query('select * from public.farm_cycle order by start_date desc')
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/cycles', async (req, res) => {
  const { name, start_date } = req.body || {}
  if (!name || !start_date) return res.status(400).json({ error: 'name and start_date are required' })
  try {
    const { rows } = await query(
      'insert into public.farm_cycle (name, start_date) values ($1, $2) returning *',
      [name, start_date]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Groups
app.get('/api/groups', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  if (!cycleId) return res.status(400).json({ error: 'cycle_id is required' })
  try {
    const { rows } = await query(
      'select * from public.herd_group where cycle_id = $1 order by number asc',
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/groups', async (req, res) => {
  const { cycle_id, number, name, group_type } = req.body || {}
  if (!cycle_id || !number) return res.status(400).json({ error: 'cycle_id and number are required' })
  try {
    const { rows } = await query(
      'insert into public.herd_group (cycle_id, number, name, group_type) values ($1, $2, $3, $4) returning *',
      [cycle_id, number, name ?? null, group_type ?? null]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.patch('/api/groups/:id', async (req, res) => {
  const id = Number(req.params.id)
  const { active } = req.body || {}
  if (!id || typeof active !== 'boolean') return res.status(400).json({ error: 'id and boolean active are required' })
  try {
    const { rows } = await query(
      'update public.herd_group set active = $1 where id = $2 returning *',
      [active, id]
    )
    res.json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Group stats
app.get('/api/group-stats', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  const idsParam = String(req.query.ids || '')
  const ids = idsParam
    .split(',')
    .map((s) => Number(s.trim()))
    .filter((n) => Number.isFinite(n) && n > 0)
  if (!cycleId || ids.length === 0) return res.json({})
  try {
    const cowCounts = await query(
      `select a.group_id, count(*)::bigint as cow_count
         from public.cow_group_assignment a
         join public.cow c on c.id = a.cow_id
        where a.end_date is null
          and c.cycle_id = $1
          and a.group_id = any($2::bigint[])
        group by a.group_id`,
      [cycleId, ids]
    )

    const usageSums = await query(
      `select group_id, coalesce(sum(qty_kg), 0) as total_usage
         from public.feed_ledger
        where lower(usage_target_type::text) = 'group'
          and lower(movement_type::text) = 'usage'
          and cycle_id = $1
          and group_id = any($2::bigint[])
        group by group_id`,
      [cycleId, ids]
    )

    const cowsByGroup = new Map()
    for (const r of cowCounts.rows) cowsByGroup.set(Number(r.group_id), Number(r.cow_count || 0))

    const foodByGroup = new Map()
    for (const r of usageSums.rows) foodByGroup.set(Number(r.group_id), Number(r.total_usage || 0))

    const out = {}
    for (const id of ids) {
      out[id] = {
        totalCows: cowsByGroup.get(id) || 0,
        totalFoodKg: foodByGroup.get(id) || 0,
      }
    }
    res.json(out)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Cows
app.get('/api/cows', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  if (!cycleId) return res.status(400).json({ error: 'cycle_id is required' })
  try {
    const { rows } = await query(
      `select c.*, a.group_id as current_group_id, g.number as current_group_number, lw.weight_kg as latest_weight_kg
         from public.cow c
         left join public.cow_group_assignment a on a.cow_id = c.id and a.end_date is null
         left join public.herd_group g on g.id = a.group_id
         left join lateral (
           select we.weight_kg
             from public.weigh_event we
            where we.cow_id = c.id
            order by we.weighed_at desc, we.created_at desc
            limit 1
         ) lw on true
        where c.cycle_id = $1
        order by c.created_at desc`,
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Single cow by id (includes same lateral latest weight join)
app.get('/api/cows/:id', async (req, res) => {
  const id = Number(req.params.id)
  if (!id) return res.status(400).json({ error: 'id is required' })
  try {
    const { rows } = await query(
      `select c.*, a.group_id as current_group_id, g.number as current_group_number, lw.weight_kg as latest_weight_kg
         from public.cow c
         left join public.cow_group_assignment a on a.cow_id = c.id and a.end_date is null
         left join public.herd_group g on g.id = a.group_id
         left join lateral (
           select we.weight_kg
             from public.weigh_event we
            where we.cow_id = c.id
            order by we.weighed_at desc, we.created_at desc
            limit 1
         ) lw on true
        where c.id = $1
        limit 1`,
      [id]
    )
    if (!rows.length) return res.status(404).json({ error: 'Not found' })
    res.json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/cows', async (req, res) => {
  const { cycle_id, external_id, breed, purchase_price, purchase_currency_code, purchase_date } = req.body || {}
  if (!cycle_id || !external_id) return res.status(400).json({ error: 'cycle_id and external_id are required' })
  if (typeof purchase_price !== 'number' || purchase_price < 0) return res.status(400).json({ error: 'numeric non-negative purchase_price is required' })
  const pcc = purchase_currency_code || 'EGP'
  const pd = purchase_date || new Date().toISOString().slice(0, 10)
  try {
    const { rows } = await query(
      'insert into public.cow (cycle_id, external_id, breed, purchase_price, purchase_currency_code, purchase_date) values ($1, $2, $3, $4, $5, $6) returning *',
      [cycle_id, external_id, breed ?? null, purchase_price, pcc, pd]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.patch('/api/cows/:id', async (req, res) => {
  const id = Number(req.params.id)
  const { status } = req.body || {}
  if (!id || !status) return res.status(400).json({ error: 'id and status are required' })
  try {
    const { rows } = await query(
      'update public.cow set status = $1 where id = $2 returning *',
      [status, id]
    )
    res.json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Cow group assignments
app.post('/api/cow-assignments', async (req, res) => {
  const { cow_id, group_id, start_date } = req.body || {}
  if (!cow_id || !group_id) return res.status(400).json({ error: 'cow_id and group_id are required' })
  const sd = start_date || new Date().toISOString().slice(0, 10)
  try {
    await query(
      'update public.cow_group_assignment set end_date = $1 where cow_id = $2 and end_date is null',
      [sd, cow_id]
    )
    const { rows } = await query(
      'insert into public.cow_group_assignment (cow_id, group_id, start_date) values ($1, $2, $3) returning *',
      [cow_id, group_id, sd]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Weigh events
app.get('/api/weigh-events', async (req, res) => {
  const cowId = Number(req.query.cow_id)
  const cycleId = Number(req.query.cycle_id)
  try {
    if (cowId) {
      const { rows } = await query(
        'select * from public.weigh_event where cow_id = $1 order by weighed_at desc',
        [cowId]
      )
      return res.json(rows)
    }
    if (cycleId) {
      const { rows } = await query(
        'select we.* from public.weigh_event we join public.cow c on c.id = we.cow_id where c.cycle_id = $1 order by we.weighed_at desc',
        [cycleId]
      )
      return res.json(rows)
    }
    res.json([])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/weigh-events', async (req, res) => {
  const { cow_id, weight_kg, weighed_at, notes } = req.body || {}
  if (!cow_id || typeof weight_kg !== 'number') return res.status(400).json({ error: 'cow_id and numeric weight_kg are required' })
  const wa = weighed_at || new Date().toISOString().slice(0, 10)
  try {
    const { rows } = await query(
      'insert into public.weigh_event (cow_id, weight_kg, weighed_at, notes) values ($1, $2, $3, $4) returning *',
      [cow_id, weight_kg, wa, notes ?? null]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Buyers
app.get('/api/buyers', async (_req, res) => {
  try {
    const { rows } = await query('select id, name from public.buyer order by name asc')
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/buyers', async (req, res) => {
  const { name } = req.body || {}
  if (!name) return res.status(400).json({ error: 'name is required' })
  try {
    const { rows } = await query('insert into public.buyer (name) values ($1) returning id, name', [name])
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Expenses
app.get('/api/expense-categories', async (_req, res) => {
  try {
    const { rows } = await query('select id, name from public.expense_category order by name asc')
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/expense-categories', async (req, res) => {
  const { name, description } = req.body || {}
  if (!name || typeof name !== 'string') return res.status(400).json({ error: 'name is required' })
  const trimmedName = name.trim()
  if (!trimmedName) return res.status(400).json({ error: 'name is required' })
  const trimmedDesc = typeof description === 'string' && description.trim() ? description.trim() : null
  try {
    const { rows } = await query(
      'insert into public.expense_category (name, description) values ($1, $2) returning id, name',
      [trimmedName, trimmedDesc]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    const message = String(e.message || e)
    if (message.toLowerCase().includes('duplicate key value')) {
      return res.status(409).json({ error: 'Expense category already exists' })
    }
    res.status(500).json({ error: message })
  }
})

app.get('/api/expenses', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  if (!cycleId) return res.status(400).json({ error: 'cycle_id is required' })
  try {
    const { rows } = await query(
      'select * from public.expense where cycle_id = $1 order by expense_date desc, created_at desc',
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/expenses', async (req, res) => {
  const { cycle_id, expense_category_id, expense_date, amount, currency_code, description } = req.body || {}
  if (!cycle_id || !expense_category_id || !expense_date || typeof amount !== 'number') {
    return res.status(400).json({ error: 'cycle_id, expense_category_id, expense_date, amount are required' })
  }
  try {
    const { rows } = await query(
      `insert into public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
       values ($1, $2, $3, $4, $5, $6) returning *`,
      [cycle_id, expense_category_id, expense_date, amount, currency_code || 'EGP', description || null]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Sales
app.get('/api/sales', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  const cowId = Number(req.query.cow_id)
  try {
    if (cowId) {
      const { rows } = await query(
        `select s.*, to_jsonb(c) - 'created_at' as cow, to_jsonb(b) - 'created_at' as buyer
           from public.sale s
           join public.cow c on c.id = s.cow_id
           join public.buyer b on b.id = s.buyer_id
          where s.cow_id = $1
          order by s.date_sold desc, s.created_at desc`,
        [cowId]
      )
      return res.json(rows)
    }
    if (!cycleId) return res.status(400).json({ error: 'cycle_id is required when cow_id is not provided' })
    const { rows } = await query(
      `select s.*, to_jsonb(c) - 'created_at' as cow, to_jsonb(b) - 'created_at' as buyer
         from public.sale s
         join public.cow c on c.id = s.cow_id
         join public.buyer b on b.id = s.buyer_id
        where c.cycle_id = $1
        order by s.date_sold desc, s.created_at desc`,
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/sales', async (req, res) => {
  const { cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes } = req.body || {}
  if (!cow_id || !buyer_id || !date_sold || typeof weight_at_sale_kg !== 'number' || typeof price_per_kg !== 'number') {
    return res.status(400).json({ error: 'cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg are required' })
  }
  try {
    const { rows } = await query(
      `insert into public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
       values ($1, $2, $3, $4, $5, $6, $7) returning *`,
      [cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code || 'EGP', notes || null]
    )
    await query('update public.cow set status = $1 where id = $2', ['sold', cow_id])
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

// Food items
app.get('/api/food-items', async (_req, res) => {
  try {
    const { rows } = await query('select id, name from public.food_item order by name asc')
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/food-items', async (req, res) => {
  const { name, unit, notes } = req.body || {}
  if (!name || typeof name !== 'string') return res.status(400).json({ error: 'name is required' })

  const trimmedName = name.trim()
  if (!trimmedName) return res.status(400).json({ error: 'name is required' })

  const trimmedUnit = typeof unit === 'string' && unit.trim() ? unit.trim() : 'kg'
  const trimmedNotes = typeof notes === 'string' && notes.trim() ? notes.trim() : null

  try {
    const { rows } = await query(
      'insert into public.food_item (name, unit, notes) values ($1, $2, $3) returning id, name, unit, notes',
      [trimmedName, trimmedUnit, trimmedNotes]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    const message = String(e.message || e)
    if (message.toLowerCase().includes('duplicate key value')) {
      return res.status(409).json({ error: 'Food item already exists' })
    }
    res.status(500).json({ error: message })
  }
})

// Feed: on-hand summary and movements
app.get('/api/feed/on-hand', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  if (!cycleId) return res.status(400).json({ error: 'cycle_id is required' })
  try {
    const { rows } = await query(
      `select food_item_id,
              coalesce(sum(case when lower(movement_type::text) in ('supply','opening','adjustment') then qty_kg else -qty_kg end), 0) as on_hand_kg
         from public.feed_ledger
        where cycle_id = $1
        group by food_item_id
        order by food_item_id asc`,
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.get('/api/feed/movements', async (req, res) => {
  const cycleId = Number(req.query.cycle_id)
  if (!cycleId) return res.status(400).json({ error: 'cycle_id is required' })
  try {
    const { rows } = await query(
      'select * from public.feed_ledger where cycle_id = $1 order by movement_date desc, created_at desc',
      [cycleId]
    )
    res.json(rows)
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/feed/supply', async (req, res) => {
  const { cycle_id, food_item_id, movement_date, qty_kg, unit_cost, total_cost, currency_code, expense_id, reference, notes } = req.body || {}
  if (!cycle_id || !food_item_id || !qty_kg) return res.status(400).json({ error: 'cycle_id, food_item_id, qty_kg are required' })
  try {
    const { rows } = await query(
      `insert into public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
       values ($1, $2, $3, $4, 'SUPPLY', $5, $6, $7, $8, $9, $10) returning *`,
      [cycle_id, food_item_id, movement_date || new Date().toISOString().slice(0, 10), qty_kg, unit_cost ?? null, total_cost ?? null, currency_code ?? null, expense_id ?? null, reference ?? null, notes ?? null]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})

app.post('/api/feed/usage', async (req, res) => {
  const { cycle_id, food_item_id, movement_date, qty_kg, usage_target_type, group_id, cow_id, notes } = req.body || {}
  if (!cycle_id || !food_item_id || !qty_kg || !usage_target_type) return res.status(400).json({ error: 'cycle_id, food_item_id, qty_kg, usage_target_type are required' })
  try {
    const { rows } = await query(
      `insert into public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
       values ($1, $2, $3, $4, 'USAGE', $5, $6, $7, $8) returning *`,
      [cycle_id, food_item_id, movement_date || new Date().toISOString().slice(0, 10), qty_kg, usage_target_type, group_id ?? null, cow_id ?? null, notes ?? null]
    )
    res.status(201).json(rows[0])
  } catch (e) {
    res.status(500).json({ error: String(e.message || e) })
  }
})
app.listen(process.env.PORT || 1988)


