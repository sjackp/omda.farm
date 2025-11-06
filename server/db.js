process.env.NODE_TLS_REJECT_UNAUTHORIZED = process.env.NODE_TLS_REJECT_UNAUTHORIZED ?? '0'
import pkg from 'pg'
import dotenv from 'dotenv'
import path from 'path'
import fs from 'fs'

// Ensure env is loaded here too (so DATABASE_URL is available even if index.js loads later)
try {
  const cwd = process.cwd()
  const parent = path.resolve(cwd, '..')
  const envFiles = [cwd, parent]
    .flatMap((dir) => ['.env', '.env.local'].map((p) => path.resolve(dir, p)))
    .filter((p) => fs.existsSync(p))
  for (const file of envFiles) dotenv.config({ path: file, override: true })
} catch {}

const { Pool } = pkg

const connectionString = process.env.DATABASE_URL

const shouldUseSSL = Boolean(
  (connectionString && /\bsslmode=require\b/i.test(connectionString)) ||
  process.env.PGSSLMODE === 'require' ||
  process.env.DATABASE_SSL === 'true'
)

export const pool = new Pool({
  connectionString,
  // Enable SSL only when explicitly required; allow self-signed chain
  ssl: shouldUseSSL ? { require: true, rejectUnauthorized: false } : undefined,
  max: 10,
  idleTimeoutMillis: 30000,
})

export async function query(text, params) {
  const start = Date.now()
  const res = await pool.query(text, params)
  const duration = Date.now() - start
  if (process.env.NODE_ENV !== 'production') {
    console.log('DB query', { rows: res.rowCount, duration, text })
  }
  return res
}


