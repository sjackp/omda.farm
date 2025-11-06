import { Fragment } from 'react'

export function SupabaseProvider({ children }: { children: React.ReactNode }) {
  return <Fragment>{children}</Fragment>
}

export function useSupabase() {
  throw new Error('Supabase has been removed')
}


