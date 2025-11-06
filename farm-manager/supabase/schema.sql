-- Supabase-ready schema for Nazamly Farm Manager
-- Enums
do $$ begin
  create type cow_status as enum ('active', 'sold', 'dead');
exception when duplicate_object then null; end $$;

do $$ begin
  create type movement_type as enum ('SUPPLY', 'USAGE', 'ADJUSTMENT', 'OPENING');
exception when duplicate_object then null; end $$;

do $$ begin
  create type usage_target_type as enum ('group', 'cow');
exception when duplicate_object then null; end $$;

-- Tables
create table if not exists public.farm_cycle (
  id bigint generated always as identity primary key,
  name text not null,
  start_date date not null,
  end_date date,
  created_at timestamptz not null default now()
);

create table if not exists public.expense_category (
  id bigint generated always as identity primary key,
  name text not null unique,
  description text,
  created_at timestamptz not null default now()
);

create table if not exists public.food_item (
  id bigint generated always as identity primary key,
  name text not null unique,
  unit text not null default 'kg',
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.herd_group (
  id bigint generated always as identity primary key,
  cycle_id bigint not null references public.farm_cycle(id) on delete cascade,
  number integer not null,
  name text,
  group_type text,
  active boolean not null default true,
  notes text,
  created_at timestamptz not null default now(),
  unique(cycle_id, number)
);

create table if not exists public.buyer (
  id bigint generated always as identity primary key,
  name text not null unique,
  phone text,
  contact_notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.cow (
  id bigint generated always as identity primary key,
  cycle_id bigint not null references public.farm_cycle(id) on delete restrict,
  external_id text not null,
  breed text,
  status cow_status not null default 'active',
  notes text,
  created_at timestamptz not null default now(),
  unique(cycle_id, external_id)
);

create table if not exists public.cow_group_assignment (
  id bigint generated always as identity primary key,
  cow_id bigint not null references public.cow(id) on delete cascade,
  group_id bigint not null references public.herd_group(id) on delete cascade,
  start_date date not null,
  end_date date,
  created_at timestamptz not null default now()
);

create table if not exists public.expense (
  id bigint generated always as identity primary key,
  cycle_id bigint not null references public.farm_cycle(id) on delete cascade,
  expense_category_id bigint not null references public.expense_category(id) on delete restrict,
  expense_date date not null,
  amount numeric not null check (amount >= 0),
  currency_code text not null default 'EGP',
  description text,
  created_at timestamptz not null default now()
);

create table if not exists public.feed_ledger (
  id bigint generated always as identity primary key,
  cycle_id bigint not null references public.farm_cycle(id) on delete cascade,
  food_item_id bigint not null references public.food_item(id) on delete restrict,
  movement_date date not null,
  qty_kg numeric not null,
  movement_type movement_type not null,
  usage_target_type usage_target_type,
  group_id bigint references public.herd_group(id) on delete set null,
  cow_id bigint references public.cow(id) on delete set null,
  unit_cost numeric,
  total_cost numeric,
  currency_code text,
  expense_id bigint references public.expense(id) on delete set null,
  reference text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.sale (
  id bigint generated always as identity primary key,
  cow_id bigint not null references public.cow(id) on delete restrict,
  buyer_id bigint not null references public.buyer(id) on delete restrict,
  date_sold date not null,
  weight_at_sale_kg numeric not null check (weight_at_sale_kg >= 0),
  price_per_kg numeric not null check (price_per_kg >= 0),
  currency_code text not null default 'EGP',
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.weigh_event (
  id bigint generated always as identity primary key,
  cow_id bigint not null references public.cow(id) on delete cascade,
  weight_kg numeric not null check (weight_kg >= 0),
  weighed_at date not null,
  notes text,
  created_at timestamptz not null default now()
);

-- Indexes
create index if not exists idx_expense_cycle_date on public.expense(cycle_id, expense_date desc);
create index if not exists idx_feed_ledger_cycle_item_date on public.feed_ledger(cycle_id, food_item_id, movement_date desc);
create index if not exists idx_weigh_event_cow_date on public.weigh_event(cow_id, weighed_at desc);
create index if not exists idx_sale_cow_date on public.sale(cow_id, date_sold desc);

-- Only one open assignment per cow
do $$ begin
  create unique index ux_cow_group_assignment_open on public.cow_group_assignment(cow_id) where end_date is null;
exception when duplicate_table then null; end $$;

-- Views
create or replace view public.v_feed_on_hand as
select
  fl.cycle_id,
  fl.food_item_id,
  sum(case when fl.movement_type in ('SUPPLY','OPENING','ADJUSTMENT') then fl.qty_kg else -fl.qty_kg end) as on_hand_kg
from public.feed_ledger fl
group by fl.cycle_id, fl.food_item_id;

create or replace view public.v_feed_avg_cost as
select
  fl.cycle_id,
  fl.food_item_id,
  case when nullif(sum(case when fl.movement_type in ('SUPPLY','OPENING') then fl.qty_kg else 0 end),0) is null then null
       else coalesce(sum(case when fl.movement_type in ('SUPPLY','OPENING') then coalesce(fl.total_cost, coalesce(fl.unit_cost,0)*fl.qty_kg) else 0 end),0)
            / nullif(sum(case when fl.movement_type in ('SUPPLY','OPENING') then fl.qty_kg else 0 end),0)
  end as avg_unit_cost
from public.feed_ledger fl
group by fl.cycle_id, fl.food_item_id;

-- RLS baseline (permissive for MVP)
alter table public.farm_cycle enable row level security;
alter table public.expense_category enable row level security;
alter table public.food_item enable row level security;
alter table public.herd_group enable row level security;
alter table public.buyer enable row level security;
alter table public.cow enable row level security;
alter table public.cow_group_assignment enable row level security;
alter table public.expense enable row level security;
alter table public.feed_ledger enable row level security;
alter table public.sale enable row level security;
alter table public.weigh_event enable row level security;

do $$ begin
  create policy "authenticated all" on public.farm_cycle for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.expense_category for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.food_item for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.herd_group for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.buyer for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.cow for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.cow_group_assignment for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.expense for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.feed_ledger for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.sale for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "authenticated all" on public.weigh_event for all to authenticated using (true) with check (true);
exception when duplicate_object then null; end $$;


