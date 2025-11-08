import { query, pool } from '../db.js'

const cycleId = Number(process.env.CYCLE_ID || 3)

async function main() {
  const { rows } = await query(
    'select id, number, name from public.herd_group where cycle_id = $1 order by number',
    [cycleId]
  )
  console.log(JSON.stringify(rows, null, 2))
}

main()
  .catch((e) => {
    console.error(e?.stack || e?.message || String(e))
    process.exitCode = 1
  })
  .finally(async () => {
    try { await pool.end() } catch {}
  })


