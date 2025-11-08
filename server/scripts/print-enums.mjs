import { query, pool } from '../db.js'

async function main() {
  const enums = ['movement_type', 'usage_target_type']
  for (const e of enums) {
    try {
      const { rows } = await query(`select unnest(enum_range(NULL::${e})) as label`)
      console.log(`${e}:`, rows.map((r) => r.label))
    } catch (err) {
      console.error(`Error reading enum ${e}:`, err?.message || err)
    }
  }
}

main()
  .catch((e) => {
    console.error(e?.stack || e?.message || String(e))
    process.exitCode = 1
  })
  .finally(async () => {
    try { await pool.end() } catch {}
  })


