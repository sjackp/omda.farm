import fs from 'fs/promises'
import path from 'path'
import url from 'url'
import { query, pool } from '../db.js'

async function main() {
  const [, , sqlFileArg] = process.argv
  if (!sqlFileArg) {
    console.error('Usage: node scripts/run-sql.js <path-to-sql-file>')
    process.exit(1)
  }

  const resolvedPath = path.resolve(process.cwd(), sqlFileArg)
  const sql = await fs.readFile(resolvedPath, 'utf8')

  try {
    console.log(`Applying SQL from: ${resolvedPath}`)
    await query(sql)
    console.log('SQL applied successfully.')
  } catch (e) {
    console.error('Error applying SQL:', e?.message || e)
    process.exitCode = 1
  } finally {
    try { await pool.end() } catch {}
  }
}

// Allow running directly
if (import.meta.url === url.pathToFileURL(process.argv[1]).href) {
  main()
}


