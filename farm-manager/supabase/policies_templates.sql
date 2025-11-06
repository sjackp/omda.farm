-- RLS policy templates and guidance for Nazamly Farm Manager
-- This file contains example Row Level Security (RLS) policies you can
-- apply per-table to restrict access to authenticated users and, when
-- desired, to table owners. The production setup should add an
-- `owner_id bigint references auth.users(id)` column (or similar) to
-- the tables you want to restrict to an owning user or team.
--
-- NOTE: The current schema in `supabase/schema.sql` enables permissive
-- "authenticated all" policies for MVP testing. Use the templates below
-- to replace those policies with stricter checks once your tables have
-- an `owner_id` or other ownership column.

-- Example: require authenticated users (read-only, but allow insert for owner)
DO $$ BEGIN
  CREATE POLICY IF NOT EXISTS "authenticated_select" ON public.farm_cycle
    FOR SELECT
    TO authenticated
    USING (true);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Example: owner-only full access (requires an owner_id column on the table)
DO $$ BEGIN
  CREATE POLICY IF NOT EXISTS "owners_full_access" ON public.herd_group
    FOR ALL
    TO authenticated
    USING (owner_id::text = auth.uid())
    WITH CHECK (owner_id::text = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Template you can apply to other tables (replace <table_name> and add owner_id column):
-- DO $$ BEGIN
--   CREATE POLICY IF NOT EXISTS "owners_full_access" ON public.<table_name>
--     FOR ALL
--     TO authenticated
--     USING (owner_id::text = auth.uid())
--     WITH CHECK (owner_id::text = auth.uid());
-- EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Short-term pragmatic policy: authenticated users can read/write (MVP)
DO $$ BEGIN
  CREATE POLICY IF NOT EXISTS "authenticated_all" ON public.expense
    FOR ALL
    TO authenticated
    USING (true)
    WITH CHECK (true);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Helpful guidance:
-- 1) To migrate a table to owner-based policies:
--    a) Add `owner_id uuid references auth.users(id)` or `owner_id text`.
--    b) Update inserts to set owner_id = auth.uid() (use DB trigger or client side).
--    c) Replace permissive policy with the "owners_full_access" template above.
-- 2) If you need team-level ownership, store `team_id` and add membership checks.
-- 3) Keep a short list of admin service roles (via jwt claims) that bypass checks if needed.

-- End of templates


