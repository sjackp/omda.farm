import { query, pool } from '../db.js'

const cycleId = Number(process.env.CYCLE_ID || 3)

async function main() {
  const { rows } = await query(
    `select count(*)::int as cnt
       from public.weigh_event we
       join public.cow c on c.id = we.cow_id
      where c.cycle_id = $1`,
    [cycleId]
  )
  console.log(JSON.stringify(rows[0], null, 2))
}

main()
  .catch((e) => {
    console.error(e?.stack || e?.message || String(e))
    process.exitCode = 1
  })
  .finally(async () => {
    try { await pool.end() } catch {}
  })


