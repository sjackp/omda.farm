# Omda Farm Server Setup

## 1) Configure database connection
Create a `.env` file in this `server/` directory (or at the repo root). The server loads both locations.

Example values:

```
# Supabase (pooler/DB):
DATABASE_URL=postgres://postgres:<PASSWORD>@<HOST>:6543/postgres?sslmode=require

# Local Postgres:
# DATABASE_URL=postgres://user:password@localhost:5432/omda_farm

# Optional (defaults to 3000)
# PORT=3000
```

## 2) Apply schema (and optional seeds)
From this `server/` directory, run:

```
npm run db:apply:schema
# Optional demo data
npm run db:apply:seeds
```

These scripts use `DATABASE_URL` and apply SQL from `../farm-manager/supabase/`.

## 3) Verify connectivity
Start the server and check health:

```
npm start
# in another terminal
curl http://localhost:3000/health
```

An `{ "ok": true }` response confirms DB connectivity.

## Notes
- Vite dev server proxies `/api/*` to `http://localhost:3000`.
- A 500 from API endpoints typically means the database is unreachable or the schema hasn't been applied yet.
