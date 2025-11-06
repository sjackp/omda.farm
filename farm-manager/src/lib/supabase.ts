// Supabase connection removed; provide a minimal stub to avoid breaking imports
type ThenableResult<T = any> = {
  then: (onFulfilled: (v: { data: T | null; error: Error | null }) => any, onRejected?: (reason: any) => any) => Promise<any>
  catch: (onRejected: (reason: any) => any) => Promise<any>
  finally: (onFinally: () => any) => Promise<any>
}

type Builder = ThenableResult & {
  select: (..._args: any[]) => Builder
  insert: (..._args: any[]) => Builder
  update: (..._args: any[]) => Builder
  order: (..._args: any[]) => Builder
  eq: (..._args: any[]) => Builder
  in: (..._args: any[]) => Builder
  is: (..._args: any[]) => Builder
  single: () => Builder
}

function makeThenable<T = any>(): ThenableResult<T> {
  const err = new Error('Database disabled')
  const res = { data: null as any, error: err }
  return {
    then: (onFulfilled, _onRejected) => Promise.resolve(onFulfilled(res)),
    catch: (onRejected) => Promise.resolve().catch(onRejected),
    finally: (onFinally) => Promise.resolve().finally(onFinally),
  }
}

function makeBuilder(): Builder {
  const thenable = makeThenable()
  const self: Builder = Object.assign(thenable, {
    select: () => self,
    insert: () => self,
    update: () => self,
    order: () => self,
    eq: () => self,
    in: () => self,
    is: () => self,
    single: () => self,
  })
  return self
}

export const supabase = {
  from: (_table: string) => makeBuilder(),
  auth: {
    getSession: async () => ({ data: { session: null }, error: null as any }),
    onAuthStateChange: () => ({ data: { subscription: { unsubscribe() {} } } }),
  },
} as any

export const isSupabaseConfigured = false

