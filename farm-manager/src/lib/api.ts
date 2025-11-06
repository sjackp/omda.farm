export const apiBaseUrl = (import.meta.env.VITE_API_URL as string | undefined) || ''

export async function apiGet<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(apiBaseUrl + path, { ...init, method: 'GET', headers: { ...(init?.headers || {}), 'Content-Type': 'application/json' } })
  if (!res.ok) throw new Error(await res.text())
  return (await res.json()) as T
}

export async function apiPost<T>(path: string, body: unknown, init?: RequestInit): Promise<T> {
  const res = await fetch(apiBaseUrl + path, { ...init, method: 'POST', body: JSON.stringify(body), headers: { ...(init?.headers || {}), 'Content-Type': 'application/json' } })
  if (!res.ok) throw new Error(await res.text())
  return (await res.json()) as T
}

export async function apiPatch<T>(path: string, body: unknown, init?: RequestInit): Promise<T> {
  const res = await fetch(apiBaseUrl + path, { ...init, method: 'PATCH', body: JSON.stringify(body), headers: { ...(init?.headers || {}), 'Content-Type': 'application/json' } })
  if (!res.ok) throw new Error(await res.text())
  return (await res.json()) as T
}


