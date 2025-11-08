import { Link, useLocation } from 'wouter'
import { Menu, Moon, Sun } from 'lucide-react'
import { useState } from 'react'
import { useTheme } from '../providers/ThemeProvider'
import { useAuth } from '../providers/AuthProvider'

const NAV = [
  { href: '/', label: 'Dashboard', icon: 'dashboard' },
  { href: '/herd', label: 'Herd', icon: 'pets' },
  { href: '/groups', label: 'Groups', icon: 'fence' },
  { href: '/feed', label: 'Feed', icon: 'grass' },
  { href: '/vaccines', label: 'Vaccines', icon: 'vaccines' },
  { href: '/sales', label: 'Sales', icon: 'receipt_long' },
  { href: '/expenses', label: 'Expenses', icon: 'paid' },
  { href: '/finance', label: 'Finance', icon: 'account_balance_wallet' },
  { href: '/cycle', label: 'Cycle', icon: 'autorenew' },
  { href: '/settings', label: 'Settings', icon: 'settings' },
]

export function Layout({ children }: { children: React.ReactNode }) {
  const [location] = useLocation()
  const [open, setOpen] = useState(false)
  const { theme, toggle } = useTheme()
  const { user, logout } = useAuth()

  // Brand-aligned muted, earthy palette (beige/olive/cream/chalk/taupe/sand)
  const iconColorByHref: Record<string, string> = {
    '/': 'text-[#6B7A3A]',          // olive
    '/herd': 'text-[#B89B74]',      // beige
    '/groups': 'text-[#8B7D6B]',    // taupe
    '/feed': 'text-[#7A8450]',      // moss/olive
    '/vaccines': 'text-[#8F8F8F]',  // chalk gray
    '/sales': 'text-[#C4B79E]',     // sand
    '/expenses': 'text-[#9E8A6D]',  // clay
    '/finance': 'text-[#5F6D3A]',   // deep olive
    '/cycle': 'text-[#DCD4BF]',     // cream
    '/settings': 'text-[#7A7D7E]',  // slate/chalk
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#f7f3ea] via-[#f5f2eb] to-[#ece8df] dark:from-[#1b2a15] dark:via-[#223019] dark:to-[#161f11] text-slate-900 dark:text-slate-100">
      <div className="w-full">
        <div className="flex">
          {/* Sidebar */}
          <aside className="hidden lg:flex w-64 shrink-0 border-r bg-white dark:bg-[#0f1110] flex-col justify-between min-h-screen">
            <div>
              <div className="h-14 flex items-center px-4 border-b font-semibold">Omda Farm</div>
              <nav className="p-2 space-y-1">
              {NAV.map((item) => {
                const active = location === item.href
                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`rounded px-3 py-2 text-sm flex items-center ${
                      active ? 'bg-slate-100 dark:bg-slate-800 font-medium' : 'hover:bg-slate-100 dark:hover:bg-slate-900'
                    }`}
                  >
                    {typeof item.icon === 'string' ? (
                      <span className={`material-symbols-outlined mr-3 ${iconColorByHref[item.href] || 'text-blue-600'}`}>{item.icon}</span>
                    ) : (
                      <span className={`mr-3 inline-flex items-center ${iconColorByHref[item.href] || 'text-blue-600'}`}>{item.icon}</span>
                    )}
                    {item.label}
                  </Link>
                )
              })}
              </nav>
            </div>
            <div className="px-4 py-3 border-t text-xs text-slate-500">
              <div className="font-medium text-slate-700 dark:text-slate-300">Farm Manager</div>
              <div>Powered by Nazamly</div>
            </div>
          </aside>

          {/* Main column */}
          <div className="min-w-0 flex-1 flex flex-col">
            <header className="h-14 border-b flex items-center px-3 gap-2 bg-white/80 dark:bg-[#131614]/80 backdrop-blur supports-[backdrop-filter]:bg-white/50 dark:supports-[backdrop-filter]:bg-[#131614]/50">
              <button className="lg:hidden inline-flex items-center justify-center h-9 w-9 rounded border hover:bg-slate-50 dark:hover:bg-slate-900" onClick={() => setOpen((o) => !o)}>
                <Menu className="h-5 w-5" />
              </button>
              <div className="font-semibold">Omda Farm</div>
              <div className="ml-auto" />
              {user && (
                <div className="hidden sm:flex items-center gap-2 text-sm text-slate-600 dark:text-slate-300 mr-2">
                  <span className="font-medium text-slate-900 dark:text-slate-100">{user.username}</span>
                </div>
              )}
              <button aria-label="Toggle theme" className="inline-flex items-center justify-center h-9 w-9 rounded border hover:bg-slate-50 dark:hover:bg-slate-900" onClick={toggle}>
                {theme === 'dark' ? <Sun className="h-5 w-5" /> : <Moon className="h-5 w-5" />}
              </button>
              <button
                className="inline-flex items-center justify-center h-9 px-3 rounded border bg-white hover:bg-slate-50 dark:bg-slate-950 dark:hover:bg-slate-900 text-sm ml-2"
                onClick={logout}
              >
                Sign out
              </button>
            </header>
            <main className="flex-1 overflow-auto p-4">{children}</main>
          </div>
        </div>
      </div>

      {/* Mobile sidebar drawer */}
      {open && (
        <div className="lg:hidden fixed inset-0 z-50 grid grid-rows-[auto_1fr] bg-white dark:bg-slate-950">
          <div className="h-14 border-b flex items-center px-3 font-semibold">Menu</div>
          <nav className="p-2 space-y-1">
            {NAV.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                onClick={() => setOpen(false)}
                className="rounded px-3 py-2 text-sm hover:bg-slate-50 dark:hover:bg-slate-900 flex items-center"
              >
                {typeof item.icon === 'string' ? (
                  <span className={`material-symbols-outlined mr-3 ${iconColorByHref[item.href] || 'text-blue-600'}`}>{item.icon}</span>
                ) : (
                  <span className={`mr-3 inline-flex items-center ${iconColorByHref[item.href] || 'text-blue-600'}`}>{item.icon}</span>
                )}
                {item.label}
              </Link>
            ))}
            <button
              className="w-full mt-4 inline-flex justify-center rounded px-3 py-2 text-sm border hover:bg-slate-50 dark:hover:bg-slate-900"
              onClick={() => {
                setOpen(false)
                logout()
              }}
            >
              Sign out
            </button>
          </nav>
        </div>
      )}
    </div>
  )
}


