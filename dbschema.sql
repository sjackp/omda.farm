-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.app_user (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  username USER-DEFINED NOT NULL UNIQUE,
  password_hash text NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  updated_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  CONSTRAINT app_user_pkey PRIMARY KEY (id)
);
CREATE TABLE public.buyer (
  id bigint NOT NULL DEFAULT nextval('buyer_id_seq'::regclass),
  name character varying NOT NULL UNIQUE,
  phone character varying,
  contact_notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT buyer_pkey PRIMARY KEY (id)
);
CREATE TABLE public.cow (
  id bigint NOT NULL DEFAULT nextval('cow_id_seq'::regclass),
  cycle_id bigint NOT NULL,
  external_id character varying NOT NULL,
  breed character varying,
  status USER-DEFINED NOT NULL DEFAULT 'active'::cow_status,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  purchase_price numeric CHECK (purchase_price >= 0::numeric),
  purchase_currency_code text NOT NULL DEFAULT 'EGP'::text,
  purchase_date date,
  CONSTRAINT cow_pkey PRIMARY KEY (id),
  CONSTRAINT cow_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.farm_cycle(id)
);
CREATE TABLE public.cow_group_assignment (
  id bigint NOT NULL DEFAULT nextval('cow_group_assignment_id_seq'::regclass),
  cow_id bigint NOT NULL,
  group_id bigint NOT NULL,
  start_date date NOT NULL,
  end_date date,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT cow_group_assignment_pkey PRIMARY KEY (id),
  CONSTRAINT cow_group_assignment_cow_id_fkey FOREIGN KEY (cow_id) REFERENCES public.cow(id),
  CONSTRAINT cow_group_assignment_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.herd_group(id)
);
CREATE TABLE public.expense (
  id bigint NOT NULL DEFAULT nextval('expense_id_seq'::regclass),
  cycle_id bigint NOT NULL,
  expense_category_id bigint NOT NULL,
  expense_date date NOT NULL,
  amount numeric NOT NULL CHECK (amount >= 0::numeric),
  currency_code character varying NOT NULL DEFAULT 'EGP'::character varying,
  description text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT expense_pkey PRIMARY KEY (id),
  CONSTRAINT expense_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.farm_cycle(id),
  CONSTRAINT expense_expense_category_id_fkey FOREIGN KEY (expense_category_id) REFERENCES public.expense_category(id)
);
CREATE TABLE public.expense_category (
  id bigint NOT NULL DEFAULT nextval('expense_category_id_seq'::regclass),
  name character varying NOT NULL UNIQUE,
  description text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT expense_category_pkey PRIMARY KEY (id)
);
CREATE TABLE public.farm_cycle (
  id bigint NOT NULL DEFAULT nextval('farm_cycle_id_seq'::regclass),
  name character varying NOT NULL,
  start_date date NOT NULL,
  end_date date,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT farm_cycle_pkey PRIMARY KEY (id)
);
CREATE TABLE public.feed_ledger (
  id bigint NOT NULL DEFAULT nextval('feed_ledger_id_seq'::regclass),
  cycle_id bigint NOT NULL,
  food_item_id bigint NOT NULL,
  movement_date date NOT NULL,
  qty_kg numeric NOT NULL,
  movement_type USER-DEFINED NOT NULL,
  usage_target_type USER-DEFINED,
  group_id bigint,
  cow_id bigint,
  unit_cost numeric,
  total_cost numeric,
  currency_code character varying,
  expense_id bigint,
  reference text,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT feed_ledger_pkey PRIMARY KEY (id),
  CONSTRAINT feed_ledger_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.farm_cycle(id),
  CONSTRAINT feed_ledger_food_item_id_fkey FOREIGN KEY (food_item_id) REFERENCES public.food_item(id),
  CONSTRAINT feed_ledger_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.herd_group(id),
  CONSTRAINT feed_ledger_cow_id_fkey FOREIGN KEY (cow_id) REFERENCES public.cow(id),
  CONSTRAINT feed_ledger_expense_id_fkey FOREIGN KEY (expense_id) REFERENCES public.expense(id)
);
CREATE TABLE public.food_item (
  id bigint NOT NULL DEFAULT nextval('food_item_id_seq'::regclass),
  name character varying NOT NULL UNIQUE,
  unit character varying NOT NULL DEFAULT 'kg'::character varying,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT food_item_pkey PRIMARY KEY (id)
);
CREATE TABLE public.herd_group (
  id bigint NOT NULL DEFAULT nextval('herd_group_id_seq'::regclass),
  cycle_id bigint NOT NULL,
  number integer NOT NULL,
  name character varying,
  group_type character varying,
  active boolean NOT NULL DEFAULT true,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT herd_group_pkey PRIMARY KEY (id),
  CONSTRAINT herd_group_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.farm_cycle(id)
);
CREATE TABLE public.sale (
  id bigint NOT NULL DEFAULT nextval('sale_id_seq'::regclass),
  cow_id bigint NOT NULL,
  buyer_id bigint NOT NULL,
  date_sold date NOT NULL,
  weight_at_sale_kg numeric NOT NULL CHECK (weight_at_sale_kg >= 0::numeric),
  price_per_kg numeric NOT NULL CHECK (price_per_kg >= 0::numeric),
  currency_code character varying NOT NULL DEFAULT 'EGP'::character varying,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT sale_pkey PRIMARY KEY (id),
  CONSTRAINT sale_cow_id_fkey FOREIGN KEY (cow_id) REFERENCES public.cow(id),
  CONSTRAINT sale_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.buyer(id)
);
CREATE TABLE public.weigh_event (
  id bigint NOT NULL DEFAULT nextval('weigh_event_id_seq'::regclass),
  cow_id bigint NOT NULL,
  weight_kg numeric NOT NULL CHECK (weight_kg >= 0::numeric),
  weighed_at date NOT NULL,
  notes text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT weigh_event_pkey PRIMARY KEY (id),
  CONSTRAINT weigh_event_cow_id_fkey FOREIGN KEY (cow_id) REFERENCES public.cow(id)
);
