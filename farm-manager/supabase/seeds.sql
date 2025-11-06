-- Seeds for categories, food items, initial cycle, and default groups (4)
insert into public.expense_category(name) values
  ('Feed'),
  ('Animal Purchase'),
  ('Transport'),
  ('Vet'),
  ('Bedding')
on conflict (name) do nothing;

insert into public.food_item(name, unit) values
  ('Fattening Feed','kg'),
  ('Straw','kg'),
  ('Summer Corn','kg'),
  ('Bran','kg'),
  ('Young Calf Feed','kg')
on conflict (name) do nothing;

-- Create initial cycle with dated name: "Cycle YYYY-MM-DD"
do $$
declare
  cycle_id bigint;
begin
  insert into public.farm_cycle(name, start_date)
  values (format('Cycle %s', current_date::text), current_date)
  returning id into cycle_id;

  -- Create default numbered groups 1..4
  insert into public.herd_group(cycle_id, number, name)
  select cycle_id, n, format('Group %s', n)
  from generate_series(1,4) as g(n);
end $$;


