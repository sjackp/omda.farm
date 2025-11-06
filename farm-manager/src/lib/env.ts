export const env = {
  supabaseUrl: import.meta.env.VITE_SUPABASE_URL as string | undefined,
  supabaseAnonKey: import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined,
  apiUrl: import.meta.env.VITE_API_URL as string | undefined,
}

export function assertEnv() {
  // No hard throw; frontend now talks to our API when configured.
  if (!env.apiUrl && import.meta.env.PROD) {
    console.warn('VITE_API_URL is not set; API calls will target same-origin')
  }
}


