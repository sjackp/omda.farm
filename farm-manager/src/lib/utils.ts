import { type ClassValue } from 'clsx'
import clsx from 'clsx'
import { twMerge } from 'tailwind-merge'

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Date utilities
function parseYmd(s: string): Date | null {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(s)
  if (!m) return null
  const y = Number(m[1])
  const mon = Number(m[2]) - 1
  const d = Number(m[3])
  const dt = new Date(y, mon, d)
  if (Number.isNaN(dt.getTime())) return null
  return dt
}

export function toDate(value: string | Date | null | undefined): Date | null {
  if (!value) return null
  if (value instanceof Date) return Number.isNaN(value.getTime()) ? null : value
  const trimmed = String(value).trim()
  if (!trimmed) return null
  // Prefer parsing YYYY-MM-DD as local date to avoid TZ shifts
  const ymd = parseYmd(trimmed)
  if (ymd) return ymd
  const dt = new Date(trimmed)
  return Number.isNaN(dt.getTime()) ? null : dt
}

const longFmt = new Intl.DateTimeFormat(undefined, { day: 'numeric', month: 'long', year: 'numeric' })
const shortMonthDayFmt = new Intl.DateTimeFormat(undefined, { month: 'short', day: 'numeric' })

export function formatHumanDate(value: string | Date | null | undefined): string {
  const dt = toDate(value)
  return dt ? longFmt.format(dt) : ''
}

export function formatMonthDay(value: string | Date | null | undefined): string {
  const dt = toDate(value)
  return dt ? shortMonthDayFmt.format(dt) : ''
}


