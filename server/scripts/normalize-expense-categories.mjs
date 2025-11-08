import { query, pool } from '../db.js'

const CANON = 'Cow'
const VARIANTS = [
  'Cow',
  'Cows',
  'Cows ( 4 )',
  'Cows ( 9 )',
  'Cows (4)',
  'Cows (9)',
]

async function getCategoryIdByName(name) {
  const { rows } = await query('select id from public.expense_category where name = $1', [name])
  return rows[0]?.id ? Number(rows[0].id) : null
}

async function ensureCategory(name) {
  let id = await getCategoryIdByName(name)
  if (id) return id
  const { rows } = await query('insert into public.expense_category (name) values ($1) returning id', [name])
  return Number(rows[0].id)
}

async function main() {
  const start = Date.now()
  await query('begin')
  try {
    const canonId = await ensureCategory(CANON)
    let moved = 0
    for (const v of VARIANTS) {
      if (v === CANON) continue
      const srcId = await getCategoryIdByName(v)
      if (!srcId) continue
      const { rows: cntRows } = await query('select count(*)::int as cnt from public.expense where expense_category_id = $1', [srcId])
      const cnt = Number(cntRows[0].cnt) || 0
      if (cnt > 0) {
        await query('update public.expense set expense_category_id = $1 where expense_category_id = $2', [canonId, srcId])
        moved += cnt
      }
      await query('delete from public.expense_category where id = $1', [srcId])
    }
    await query('commit')
    const duration = Date.now() - start
    console.log(JSON.stringify({ status: 'ok', canonical: CANON, moved, ms: duration }, null, 2))
  } catch (e) {
    await query('rollback')
    console.error('Normalization failed:', e?.message || e)
    process.exitCode = 1
  } finally {
    try { await pool.end() } catch {}
  }
}

main()


