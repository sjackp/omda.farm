import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import xlsx from 'xlsx'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const repoRoot = path.resolve(__dirname, '..', '..')
const outDir = path.resolve(__dirname, '..', 'imports', 'current_cycle')

// Resolve input files:
// - Prefer explicit paths via EXCEL_COWS and EXCEL_USAGE env vars
// - Fallback to repo-root defaults if present
const defaultCowsPath = path.resolve(repoRoot, 'Cows 1.xlsx')
const defaultUsagePath = path.resolve(repoRoot, 'Updated_Daily_Usage_Tracker_Linked.xlsx')
const SOURCE_FILES = [
  process.env.EXCEL_COWS ? path.resolve(process.env.EXCEL_COWS) : defaultCowsPath,
  process.env.EXCEL_USAGE ? path.resolve(process.env.EXCEL_USAGE) : defaultUsagePath,
]

function ensureDir(dirPath) {
  fs.mkdirSync(dirPath, { recursive: true })
}

function csvEscape(value) {
  if (value === null || value === undefined) return ''
  const str = String(value)
  if (str.includes('"') || str.includes(',') || str.includes('\n') || str.includes('\r')) {
    return `"${str.replace(/"/g, '""')}"`
  }
  return str
}

function writeCsv(filepath, rows, headerOrder) {
  if (!rows || rows.length === 0) {
    fs.writeFileSync(filepath, '')
    return
  }
  const headers = headerOrder && headerOrder.length ? headerOrder : Array.from(
    rows.reduce((set, row) => {
      Object.keys(row).forEach((k) => set.add(k))
      return set
    }, new Set())
  )
  const lines = []
  lines.push(headers.map(csvEscape).join(','))
  for (const row of rows) {
    const line = headers.map((h) => csvEscape(row[h] ?? '')).join(',')
    lines.push(line)
  }
  fs.writeFileSync(filepath, lines.join('\n'))
}

function toIsoDate(d) {
  if (!d) return null
  if (d instanceof Date && !isNaN(d.getTime())) {
    return d.toISOString().slice(0, 10)
  }
  const s = String(d).trim()
  if (!s) return null
  // Try common formats: YYYY-MM-DD, DD/MM/YYYY, MM/DD/YYYY
  const ymd = s.match(/^(\d{4})-(\d{1,2})-(\d{1,2})$/)
  if (ymd) {
    const [ , y, m, day ] = ymd
    const date = new Date(Number(y), Number(m) - 1, Number(day))
    return isNaN(date.getTime()) ? null : date.toISOString().slice(0, 10)
  }
  const dmy = s.match(/^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{2,4})$/)
  if (dmy) {
    let [ , day, m, y ] = dmy
    if (y.length === 2) y = `20${y}`
    const date = new Date(Number(y), Number(m) - 1, Number(day))
    return isNaN(date.getTime()) ? null : date.toISOString().slice(0, 10)
  }
  // Last attempt: Date.parse
  const parsed = new Date(s)
  return isNaN(parsed.getTime()) ? null : parsed.toISOString().slice(0, 10)
}

function toNumber(n) {
  if (n === null || n === undefined || n === '') return null
  if (typeof n === 'number') return isFinite(n) ? n : null
  const clean = String(n).replace(/[, ]/g, '')
  const parsed = Number(clean)
  return isFinite(parsed) ? parsed : null
}

function normalizeFoodName(name) {
  if (!name) return null
  return String(name).trim()
}

function normalizeGroupLabel(label) {
  if (!label) return null
  return String(label).trim()
}

function extractGroupNumberFromLabel(label) {
  // Map 'Group A' -> 1, 'Group B' -> 2, etc. If a numeric suffix exists, use it instead.
  if (!label) return null
  const s = String(label).trim()
  const mNum = s.match(/(\d+)$/)
  if (mNum) return Number(mNum[1])
  const mAlpha = s.match(/group\s*([A-Z])/i)
  if (mAlpha) {
    const code = mAlpha[1].toUpperCase().charCodeAt(0) - 'A'.charCodeAt(0) + 1
    return code > 0 ? code : null
  }
  return null
}

function sanitizeForPath(name) {
  return String(name).replace(/[\\/:*?"<>|]+/g, '_').replace(/\s+/g, '_')
}

function dumpWorkbookRaw(wb, workbookLabel) {
  const rawRoot = path.resolve(outDir, 'raw', sanitizeForPath(workbookLabel))
  ensureDir(rawRoot)
  for (const sheetName of wb.SheetNames) {
    const ws = wb.Sheets[sheetName]
    const csv = xlsx.utils.sheet_to_csv(ws)
    const outPath = path.resolve(rawRoot, `${sanitizeForPath(sheetName)}.csv`)
    fs.writeFileSync(outPath, csv)
  }
}

function profileWorkbook(wb, workbookLabel, overviewRows, auditRows) {
  for (const sheetName of wb.SheetNames) {
    const rows = xlsx.utils.sheet_to_json(wb.Sheets[sheetName], { defval: null })
    const rowCount = rows.length
    const colSet = new Set()
    rows.forEach((r) => Object.keys(r).forEach((k) => colSet.add(k)))
    const columns = Array.from(colSet)

    // Candidate keys: columns with non-null == rowCount and unique == rowCount
    const candidateKeys = []
    for (const col of columns) {
      let nonNull = 0
      const seen = new Set()
      for (const r of rows) {
        const v = r[col]
        if (v !== null && v !== undefined && v !== '') {
          nonNull += 1
          seen.add(String(v))
        }
      }
      if (rowCount > 0 && nonNull === rowCount && seen.size === rowCount) {
        candidateKeys.push(col)
      }
    }
    overviewRows.push({
      Workbook: workbookLabel,
      Sheet: sheetName,
      Rows: rowCount,
      Columns: columns.length,
      'Candidate key(s)': candidateKeys.join('; '),
    })

    // Column audit
    for (const col of columns) {
      const values = rows.map((r) => r[col]).filter((v) => v !== null && v !== undefined && v !== '')
      const nonNull = values.length
      const unique = new Set(values.map((v) => String(v))).size
      const dtype = (() => {
        if (values.length === 0) return 'unknown'
        const allNumbers = values.every((v) => typeof v === 'number')
        if (allNumbers) return 'number'
        const allDates = values.every((v) => (v instanceof Date) || (typeof v === 'string' && toIsoDate(v)))
        if (allDates) return 'date'
        return 'string'
      })()
      const sample = values.slice(0, 3).map((v) => (v instanceof Date ? toIsoDate(v) : String(v))).join(', ')
      auditRows.push({
        Workbook: workbookLabel,
        Sheet: sheetName,
        Column: col,
        Dtype: dtype,
        'Non‑Null': nonNull,
        Unique: unique,
        'Sample values': sample,
      })
    }
  }
}

function buildSqlInserts(context, options = {}) {
  const {
    cycleName,
    cycleStart,
    cycleEnd,
    buyers,
    expenseCategories,
    foodItems,
    herdGroups,
    cows,
    cowAssignments,
    weighEvents,
    expenses,
    sales,
    feedSupply,
    feedUsage,
  } = context
  const {
    activeCycleId = process.env.ACTIVE_CYCLE_ID ? Number(process.env.ACTIVE_CYCLE_ID) : null,
    activeCycleName = process.env.ACTIVE_CYCLE_NAME || null,
    skipGroupInserts = String(process.env.SKIP_GROUP_INSERTS || '').toLowerCase() === 'true',
  } = options

  const q = (s) => s == null ? 'NULL' : `'${String(s).replace(/'/g, "''")}'`
  const n = (v) => v == null ? 'NULL' : String(v)
  const neg = (v) => {
    if (v == null) return 'NULL'
    const num = Number(v)
    if (!isFinite(num)) return 'NULL'
    return String(-Math.abs(num))
  }

  const lines = []
  lines.push('-- Auto-generated import for current cycle')
  lines.push('BEGIN;')
  lines.push('')

  // Cycle handling
  if (!activeCycleId && !activeCycleName) {
    lines.push(`-- Farm cycle (created if not exists)`)
    lines.push(
      `INSERT INTO public.farm_cycle (name, start_date, end_date)
SELECT ${q(cycleName)}, ${q(cycleStart)}, ${q(cycleEnd)}
WHERE NOT EXISTS (SELECT 1 FROM public.farm_cycle WHERE name = ${q(cycleName)});`
    )
    lines.push('')
  } else {
    lines.push(`-- Targeting existing active cycle ${activeCycleId ? `id=${activeCycleId}` : `name=${activeCycleName}`}`)
    lines.push('')
  }

  // Reference sets with ON CONFLICT
  lines.push(`-- Expense categories`)
  for (const name of Array.from(expenseCategories).sort()) {
    lines.push(`INSERT INTO public.expense_category (name) VALUES (${q(name)}) ON CONFLICT (name) DO NOTHING;`)
  }
  lines.push('')

  lines.push(`-- Food items`)
  for (const name of Array.from(foodItems).sort()) {
    lines.push(`INSERT INTO public.food_item (name, unit) VALUES (${q(name)}, 'kg') ON CONFLICT (name) DO NOTHING;`)
  }
  lines.push('')

  lines.push(`-- Buyers`)
  for (const name of Array.from(buyers).sort()) {
    if (!name) continue
    lines.push(`INSERT INTO public.buyer (name) VALUES (${q(name)}) ON CONFLICT (name) DO NOTHING;`)
  }
  lines.push('')

  // Herd groups
  if (!skipGroupInserts && !activeCycleId && !activeCycleName) {
    lines.push(`-- Herd groups (created if not exists)`)
    for (const g of herdGroups) {
      lines.push(
        `INSERT INTO public.herd_group (cycle_id, number, name, group_type, active, notes)
SELECT fc.id, ${n(g.number)}, ${q(g.name)}, NULL, true, NULL
FROM public.farm_cycle fc
WHERE fc.name = ${q(cycleName)}
  AND NOT EXISTS (
    SELECT 1 FROM public.herd_group hg WHERE hg.cycle_id = fc.id AND hg.number = ${n(g.number)}
  );`
      )
    }
    lines.push('')
  }

  // Helper to select target cycle
  const cycleWhere = activeCycleId
    ? `fc.id = ${Number(activeCycleId)}`
    : (activeCycleName ? `fc.name = ${q(activeCycleName)}` : `fc.name = ${q(cycleName)}`)

  // Cows
  lines.push(`-- Cows`)
  for (const cow of cows) {
    lines.push(
      `INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, ${q(cow.external_id)}, ${q(cow.breed)}, 'active', ${q(cow.notes ?? null)}, 'EGP', NULL
FROM public.farm_cycle fc
WHERE ${cycleWhere}
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = ${q(cow.external_id)}
  );`
    )
  }
  lines.push('')

  // Cow group assignments
  lines.push(`-- Cow group assignments`)
  for (const a of cowAssignments) {
    lines.push(
      `INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, ${q(a.start_date)}, NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = ${q(a.external_id)}
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = ${n(a.group_number)}
WHERE ${cycleWhere}
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = ${q(a.start_date)}
  );`
    )
  }
  lines.push('')

  // Weigh events
  lines.push(`-- Weigh events`)
  for (const w of weighEvents) {
    lines.push(
      `INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, ${n(w.weight_kg)}, ${q(w.weighed_at)}, ${q(w.notes ?? null)}
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = ${q(w.external_id)}
WHERE ${cycleWhere};`
    )
  }
  lines.push('')

  // Expenses
  lines.push(`-- Expenses`)
  for (const e of expenses) {
    lines.push(
      `INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, ${q(e.expense_date)}, ${n(e.amount)}, 'EGP', ${q(e.description ?? null)}
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = ${q(e.category)}
WHERE ${cycleWhere};`
    )
  }
  lines.push('')

  // Sales
  lines.push(`-- Sales`)
  for (const s of sales) {
    lines.push(
      `INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, ${q(s.date_sold)}, ${n(s.weight_at_sale_kg)}, ${n(s.price_per_kg)}, 'EGP', ${q(s.notes ?? null)}
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = ${q(s.external_id)}
JOIN public.buyer b ON b.name = ${q(s.buyer_name)}
WHERE ${cycleWhere};`
    )
  }
  lines.push('')

  // Feed supply (SUPPLY)
  lines.push(`-- Feed supply movements`)
  for (const f of feedSupply) {
    lines.push(
      `INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, ${q(f.movement_date)}, ${n(f.qty_kg)}, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = ${q(f.food_name)}
WHERE ${cycleWhere};`
    )
  }
  lines.push('')

  // Feed usage (USAGE) - group or cow
  lines.push(`-- Feed usage movements`)
  for (const f of feedUsage) {
    if (f.usage_target_type === 'group') {
      lines.push(
        `INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, ${q(f.movement_date)}, ${neg(f.qty_kg)}, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = ${q(f.food_name)}
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = ${n(f.group_number)}
WHERE ${cycleWhere};`
      )
    } else if (f.usage_target_type === 'cow') {
      lines.push(
        `INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, ${q(f.movement_date)}, ${neg(f.qty_kg)}, 'usage', 'cow', NULL, c.id, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = ${q(f.food_name)}
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = ${q(f.external_id)}
WHERE ${cycleWhere};`
      )
    }
  }
  lines.push('')

  lines.push('COMMIT;')
  lines.push('')
  return lines.join('\n')
}

function main() {
  ensureDir(outDir)

  // Containers
  const buyers = new Set()
  const expenseCategories = new Set()
  const foodItems = new Set()
  const herdGroupLabels = new Set()
  const herdGroups = []
  const cowsByExternalId = new Map()
  const cowAssignments = []
  const weighEvents = []
  const expenses = []
  const sales = []
  const feedSupply = []
  const feedUsage = []

  let minDate = null
  let maxDate = null
  const trackDate = (d) => {
    const iso = toIsoDate(d)
    if (!iso) return
    if (!minDate || iso < minDate) minDate = iso
    if (!maxDate || iso > maxDate) maxDate = iso
  }

  // Read workbooks
  const [wbCows, wbUsage] = SOURCE_FILES.map((p) => {
    if (!fs.existsSync(p)) {
      throw new Error(`Source file not found: ${p}`)
    }
    return xlsx.readFile(p, { cellDates: true })
  })

  // RAW dumps and profiling first
  dumpWorkbookRaw(wbCows, path.basename(SOURCE_FILES[0]))
  dumpWorkbookRaw(wbUsage, path.basename(SOURCE_FILES[1]))
  const overviewRows = []
  const auditRows = []
  profileWorkbook(wbCows, path.basename(SOURCE_FILES[0]), overviewRows, auditRows)
  profileWorkbook(wbUsage, path.basename(SOURCE_FILES[1]), overviewRows, auditRows)
  writeCsv(path.resolve(outDir, 'workbook_overview.csv'), overviewRows, ['Workbook', 'Sheet', 'Rows', 'Columns', 'Candidate key(s)'])
  writeCsv(path.resolve(outDir, 'column_by_column_audit.csv'), auditRows, ['Workbook', 'Sheet', 'Column', 'Dtype', 'Non‑Null', 'Unique', 'Sample values'])

  // From "Cows 1.xlsx"
  {
    const sheets = Object.fromEntries(wbCows.SheetNames.map((n) => [n, n]))
    // Cow Quantity
    if (sheets['Cow Quantity']) {
      const rows = xlsx.utils.sheet_to_json(wbCows.Sheets['Cow Quantity'], { defval: null })
      for (const r of rows) {
        const externalId = r['Cow ID'] != null ? String(r['Cow ID']).trim() : null
        if (!externalId) continue
        // Cow
        const breed = r['Breed '] ?? r['Breed'] ?? null
        const notes = r['Notes'] ?? null
        if (!cowsByExternalId.has(externalId)) {
          cowsByExternalId.set(externalId, {
            external_id: externalId,
            breed: breed ? String(breed).trim() : null,
            notes: notes ? String(notes).trim() : null,
          })
        }
        // Group assignment
        const groupLabel = normalizeGroupLabel(r['Cow Group'])
        const startDate = toIsoDate(r['Date'])
        if (groupLabel && startDate) {
          herdGroupLabels.add(groupLabel)
          const group_number = extractGroupNumberFromLabel(groupLabel)
          cowAssignments.push({
            external_id: externalId,
            group_label: groupLabel,
            group_number,
            start_date: startDate,
          })
          trackDate(startDate)
        }
      }
    }

    // Growth Tracker
    if (sheets['Growth Tracker']) {
      const rows = xlsx.utils.sheet_to_json(wbCows.Sheets['Growth Tracker'], { defval: null })
      for (const r of rows) {
        const externalId = r['Cow ID'] != null ? String(r['Cow ID']).trim() : null
        const weight = toNumber(r['Weight (kg)'])
        const dateWeighed = toIsoDate(r['Date Weighed'])
        const notes = r['Growth Notes'] ? String(r['Growth Notes']).trim() : null
        if (externalId && weight != null && dateWeighed) {
          weighEvents.push({
            external_id: externalId,
            weight_kg: weight,
            weighed_at: dateWeighed,
            notes,
          })
          trackDate(dateWeighed)
        }
      }
    }

    // Expenses
    if (sheets['Expenses']) {
      const rows = xlsx.utils.sheet_to_json(wbCows.Sheets['Expenses'], { defval: null })
      const normalizeCategory = (raw) => {
        const n = (raw ?? '').toString().trim()
        // Collapse "Cows ( 4 )", "Cows ( 9 )", "Cows", "Cow" => "Cow"
        if (/^cows?\s*(\(\s*\d+\s*\))?$/i.test(n)) return 'Cow'
        return n
      }
      for (const r of rows) {
        const date = toIsoDate(r['Date'])
        const category = r['Expense Type'] ? normalizeCategory(r['Expense Type']) : null
        const amount = toNumber(r['Amount ($)'])
        const description = r['Description'] ? String(r['Description']).trim() : null
        if (category) expenseCategories.add(category)
        if (date && category && amount != null) {
          expenses.push({
            expense_date: date,
            category,
            amount,
            description,
          })
          trackDate(date)
        }
      }
    }

    // Selling
    if (sheets['Selling']) {
      const rows = xlsx.utils.sheet_to_json(wbCows.Sheets['Selling'], { defval: null })
      for (const r of rows) {
        const externalId = r['Cow ID'] != null ? String(r['Cow ID']).trim() : null
        const dateSold = toIsoDate(r['Date Sold'])
        const weightAtSale = toNumber(r['Weight at Sale (kg)'])
        const pricePerKilo = toNumber(r['Price Per Kilo'])
        const buyerName = r['Buyer Name'] ? String(r['Buyer Name']).trim() : null
        const notes = r['Notes'] ? String(r['Notes']).trim() : null
        if (buyerName) buyers.add(buyerName)
        if (externalId && dateSold && weightAtSale != null && pricePerKilo != null && buyerName) {
          sales.push({
            external_id: externalId,
            date_sold: dateSold,
            weight_at_sale_kg: weightAtSale,
            price_per_kg: pricePerKilo,
            buyer_name: buyerName,
            notes,
          })
          trackDate(dateSold)
        }
      }
    }

    // Food Quantity (supply)
    if (sheets['Food Quantity']) {
      const rows = xlsx.utils.sheet_to_json(wbCows.Sheets['Food Quantity'], { defval: null })
      for (const r of rows) {
        const date = toIsoDate(r['Date'])
        const food = normalizeFoodName(r['Food Type'])
        const totalSupplied = toNumber(r['Total Supplied (kg)'])
        if (food) foodItems.add(food)
        if (date && food && totalSupplied != null && totalSupplied > 0) {
          feedSupply.push({
            movement_date: date,
            food_name: food,
            qty_kg: totalSupplied,
          })
          trackDate(date)
        }
      }
    }
  }

  // From "Updated_Daily_Usage_Tracker_Linked.xlsx"
  {
    const sheetName = 'Daily Usage Tracker'
    if (wbUsage.SheetNames.includes(sheetName)) {
      const rows = xlsx.utils.sheet_to_json(wbUsage.Sheets[sheetName], { defval: null })
      for (const r of rows) {
        const date = toIsoDate(r['Date'])
        const food = normalizeFoodName(r['Food Type'])
        const qty = toNumber(r['Quantity Used (kg)'])
        const usedFor = r['Used For (Cow ID or Group)'] ? String(r['Used For (Cow ID or Group)']).trim() : null
        if (food) foodItems.add(food)
        if (date && food && qty != null && qty > 0 && usedFor) {
          const groupMatch = usedFor.match(/^group\s*([A-Z]|\d+)$/i)
          if (groupMatch) {
            const label = usedFor.match(/^group\s*[A-Z]$/i) ? `Group ${groupMatch[1].toUpperCase()}` : `Group ${groupMatch[1]}`
            const number = extractGroupNumberFromLabel(label)
            herdGroupLabels.add(label)
            feedUsage.push({
              usage_target_type: 'group',
              movement_date: date,
              food_name: food,
              qty_kg: qty,
              group_number: number,
            })
            trackDate(date)
            continue
          }
          const cowIdNum = toNumber(usedFor)
          if (cowIdNum != null) {
            const externalId = String(cowIdNum)
            if (!cowsByExternalId.has(externalId)) {
              cowsByExternalId.set(externalId, { external_id: externalId, breed: null, notes: null })
            }
            feedUsage.push({
              usage_target_type: 'cow',
              movement_date: date,
              food_name: food,
              qty_kg: qty,
              external_id: externalId,
            })
            trackDate(date)
          }
        }
      }
    }
  }

  // Herd groups normalization
  for (const label of Array.from(herdGroupLabels)) {
    herdGroups.push({
      name: label,
      number: extractGroupNumberFromLabel(label),
    })
  }
  herdGroups.sort((a, b) => (a.number ?? 0) - (b.number ?? 0))

  // Cows list
  const cows = Array.from(cowsByExternalId.values()).map((c) => ({
    external_id: c.external_id,
    breed: c.breed ?? 'Holstein',
    notes: c.notes ?? null,
  }))
  cows.sort((a, b) => a.external_id.localeCompare(b.external_id))

  // Cow assignments dedupe by (external_id, group_number, start_date)
  const assignmentSeen = new Set()
  const dedupAssignments = []
  for (const a of cowAssignments) {
    const key = `${a.external_id}|${a.group_number}|${a.start_date}`
    if (assignmentSeen.has(key)) continue
    assignmentSeen.add(key)
    dedupAssignments.push(a)
  }
  dedupAssignments.sort((a, b) => {
    if (a.external_id !== b.external_id) return a.external_id.localeCompare(b.external_id)
    if (a.group_number !== b.group_number) return (a.group_number ?? 0) - (b.group_number ?? 0)
    return a.start_date.localeCompare(b.start_date)
  })

  // Weigh events sort by date
  weighEvents.sort((a, b) => {
    if (a.external_id !== b.external_id) return a.external_id.localeCompare(b.external_id)
    return a.weighed_at.localeCompare(b.weighed_at)
  })

  // Expenses sort by date
  expenses.sort((a, b) => a.expense_date.localeCompare(b.expense_date))

  // Sales sort by date
  sales.sort((a, b) => a.date_sold.localeCompare(b.date_sold))

  // Feed movements sort by date
  feedSupply.sort((a, b) => a.movement_date.localeCompare(b.movement_date))
  feedUsage.sort((a, b) => a.movement_date.localeCompare(b.movement_date))

  // Cycle derivation
  const cycleStart = minDate
  const cycleEnd = maxDate
  const cycleName = `Cycle ${cycleStart}_to_${cycleEnd}`

  // Output CSVs (cleaned datasets)
  ensureDir(outDir)
  writeCsv(path.resolve(outDir, 'farm_cycle.csv'), [{ name: cycleName, start_date: cycleStart, end_date: cycleEnd }], ['name', 'start_date', 'end_date'])
  writeCsv(path.resolve(outDir, 'buyer.csv'), Array.from(buyers).filter(Boolean).map((name) => ({ name })), ['name'])
  writeCsv(path.resolve(outDir, 'expense_category.csv'), Array.from(expenseCategories).map((name) => ({ name })), ['name'])
  writeCsv(path.resolve(outDir, 'food_item.csv'), Array.from(foodItems).map((name) => ({ name, unit: 'kg' })), ['name', 'unit'])
  writeCsv(path.resolve(outDir, 'herd_group.csv'), herdGroups.map((g) => ({ cycle_name: cycleName, number: g.number, name: g.name })), ['cycle_name', 'number', 'name'])
  writeCsv(path.resolve(outDir, 'cow.csv'), cows.map((c) => ({ cycle_name: cycleName, external_id: c.external_id, breed: c.breed, status: 'active', notes: c.notes })), ['cycle_name', 'external_id', 'breed', 'status', 'notes'])
  writeCsv(path.resolve(outDir, 'cow_group_assignment.csv'), dedupAssignments.map((a) => ({ cycle_name: cycleName, external_id: a.external_id, group_number: a.group_number, start_date: a.start_date })), ['cycle_name', 'external_id', 'group_number', 'start_date'])
  writeCsv(path.resolve(outDir, 'weigh_event.csv'), weighEvents.map((w) => ({ cycle_name: cycleName, external_id: w.external_id, weight_kg: w.weight_kg, weighed_at: w.weighed_at, notes: w.notes })), ['cycle_name', 'external_id', 'weight_kg', 'weighed_at', 'notes'])
  writeCsv(path.resolve(outDir, 'expense.csv'), expenses.map((e) => ({ cycle_name: cycleName, category: e.category, expense_date: e.expense_date, amount: e.amount, currency_code: 'EGP', description: e.description })), ['cycle_name', 'category', 'expense_date', 'amount', 'currency_code', 'description'])
  writeCsv(path.resolve(outDir, 'sale.csv'), sales.map((s) => ({ cycle_name: cycleName, external_id: s.external_id, buyer_name: s.buyer_name, date_sold: s.date_sold, weight_at_sale_kg: s.weight_at_sale_kg, price_per_kg: s.price_per_kg, currency_code: 'EGP', notes: s.notes })), ['cycle_name', 'external_id', 'buyer_name', 'date_sold', 'weight_at_sale_kg', 'price_per_kg', 'currency_code', 'notes'])
  writeCsv(path.resolve(outDir, 'feed_supply.csv'), feedSupply.map((f) => ({ cycle_name: cycleName, food_name: f.food_name, movement_date: f.movement_date, qty_kg: f.qty_kg })), ['cycle_name', 'food_name', 'movement_date', 'qty_kg'])
  writeCsv(path.resolve(outDir, 'feed_usage.csv'), feedUsage.map((f) => {
    if (f.usage_target_type === 'group') {
      return { cycle_name: cycleName, food_name: f.food_name, movement_date: f.movement_date, qty_kg: f.qty_kg, usage_target_type: 'group', group_number: f.group_number }
    }
    return { cycle_name: cycleName, food_name: f.food_name, movement_date: f.movement_date, qty_kg: f.qty_kg, usage_target_type: 'cow', external_id: f.external_id }
  }), ['cycle_name', 'food_name', 'movement_date', 'qty_kg', 'usage_target_type', 'group_number', 'external_id'])

  // Output ready-to-run SQL
  const sql = buildSqlInserts({
    cycleName,
    cycleStart,
    cycleEnd,
    buyers,
    expenseCategories,
    foodItems,
    herdGroups,
    cows,
    cowAssignments: dedupAssignments,
    weighEvents,
    expenses,
    sales,
    feedSupply,
    feedUsage,
  })
  fs.writeFileSync(path.resolve(outDir, 'import.sql'), sql)

  // Report summary JSON
  const summary = {
    cycleName,
    cycleStart,
    cycleEnd,
    counts: {
      buyers: buyers.size,
      expenseCategories: expenseCategories.size,
      foodItems: foodItems.size,
      herdGroups: herdGroups.length,
      cows: cows.length,
      cowAssignments: dedupAssignments.length,
      weighEvents: weighEvents.length,
      expenses: expenses.length,
      sales: sales.length,
      feedSupply: feedSupply.length,
      feedUsage: feedUsage.length,
    },
    sources: SOURCE_FILES,
    generatedAt: new Date().toISOString(),
  }
  fs.writeFileSync(path.resolve(outDir, 'summary.json'), JSON.stringify(summary, null, 2))

  // Validation report
  const warnings = []
  if (weighEvents.length === 0) warnings.push('No weigh events detected.')
  const groupUsageCount = feedUsage.filter((f) => f.usage_target_type === 'group').length
  if (groupUsageCount === 0) warnings.push('No group usage detected in feed usage.')
  const unmappedCowCats = Array.from(expenseCategories).filter((n) => /^cows?\s*(\(\s*\d+\s*\))?$/i.test(n))
  if (unmappedCowCats.length > 0) warnings.push(`Unnormalized cow categories found: ${unmappedCowCats.join(', ')}`)
  const validation = {
    warnings,
    counts: summary.counts,
  }
  fs.writeFileSync(path.resolve(outDir, 'validation.txt'), [ 'Validation Report', '==================', '', ...warnings.map((w) => `- ${w}`) ].join('\n'))

  // Console output
  // eslint-disable-next-line no-console
  console.log('Extraction complete. Outputs in:', path.relative(repoRoot, outDir))
  // eslint-disable-next-line no-console
  console.log('Counts:', summary.counts)
  if (warnings.length) {
    // eslint-disable-next-line no-console
    console.warn('Validation warnings:', warnings)
  }
}

try {
  main()
} catch (err) {
  // eslint-disable-next-line no-console
  console.error(err?.stack || err?.message || String(err))
  process.exitCode = 1
}


