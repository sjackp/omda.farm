import { useEffect, useState } from 'react'

export default function Settings() {
  const [currency, setCurrency] = useState('EGP')
  const [defaultGroups, setDefaultGroups] = useState(8)

  useEffect(() => {
    const c = localStorage.getItem('defaultCurrency') || 'EGP'
    const g = Number(localStorage.getItem('defaultGroups') || '8')
    setCurrency(c)
    setDefaultGroups(g)
  }, [])

  function save() {
    localStorage.setItem('defaultCurrency', currency)
    localStorage.setItem('defaultGroups', String(defaultGroups))
    // eslint-disable-next-line no-console
    console.log('Settings saved')
  }

  return (
    <div>
      <h1 className="text-xl font-semibold mb-4">Settings</h1>
      <div className="rounded border p-4 space-y-2">
        <div className="flex items-center gap-2">
          <label className="text-sm">Default currency</label>
          <input className="border rounded px-2 py-1" value={currency} onChange={(e) => setCurrency(e.target.value)} />
        </div>
        <div className="flex items-center gap-2">
          <label className="text-sm">Default groups per cycle</label>
          <input type="number" className="border rounded px-2 py-1" value={defaultGroups} onChange={(e) => setDefaultGroups(Number(e.target.value))} />
        </div>
        <div>
          <button className="rounded bg-blue-600 text-white px-3 py-1" onClick={save}>Save</button>
        </div>
      </div>
    </div>
  )
}


