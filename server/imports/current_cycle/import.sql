-- Auto-generated import for current cycle
BEGIN;

-- Targeting existing active cycle id=3

-- Expense categories
INSERT INTO public.expense_category (name) VALUES ('Cow') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Cows ( 4 )') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Cows ( 9 )') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Cows Transportation') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Feed') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Food Transportation') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Netting') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Ropes') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Straw') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Straw Transportation') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Vet') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.expense_category (name) VALUES ('Wormwood') ON CONFLICT (name) DO NOTHING;

-- Food items
INSERT INTO public.food_item (name, unit) VALUES ('Bran', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Corn', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Fattening Feed', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Hay', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Straw', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Summer Corn', 'kg') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.food_item (name, unit) VALUES ('Young Calf Feed', 'kg') ON CONFLICT (name) DO NOTHING;

-- Buyers
INSERT INTO public.buyer (name) VALUES ('Ahmed Hazem') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('Ahmed Maher') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('El Omda') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('Essam El Gawhara') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('Karam Sabry') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('Mr Mahmoud') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.buyer (name) VALUES ('Youssry El Maghraby') ON CONFLICT (name) DO NOTHING;

-- Cows
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '736', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '736'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '737', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '737'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '738', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '738'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '741', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '741'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '742', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '742'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '743', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '743'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '744', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '744'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '745', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '745'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '748', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '748'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '749', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '749'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '750', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '750'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '751', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '751'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '752', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '752'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '763', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '763'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, '764', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = '764'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, 'B', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = 'B'
  );
INSERT INTO public.cow (cycle_id, external_id, breed, status, notes, purchase_currency_code, purchase_date)
SELECT fc.id, 'W', 'Holstein', 'active', 'Sold', 'EGP', NULL
FROM public.farm_cycle fc
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow c WHERE c.cycle_id = fc.id AND c.external_id = 'W'
  );

-- Cow group assignments
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '736'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '737'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '738'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '741'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '742'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '743'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '744'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '745'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-03-09', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '748'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-03-09'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '749'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '750'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '751'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '752'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '763'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '764'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = 'B'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );
INSERT INTO public.cow_group_assignment (cow_id, group_id, start_date, end_date)
SELECT c.id, hg.id, '2025-04-26', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = 'W'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3
  AND NOT EXISTS (
    SELECT 1 FROM public.cow_group_assignment x WHERE x.cow_id = c.id AND x.group_id = hg.id AND x.start_date = '2025-04-26'
  );

-- Weigh events
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 590, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '736'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 545, '2025-03-26', 'Initial'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '737'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 538, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '738'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 536, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '741'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 499, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '742'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 495, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '743'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 571, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '744'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 564, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '745'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 496, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '748'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 470, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '749'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 466, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '750'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 440, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '751'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 419, '2025-05-18', NULL
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '752'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 293, '2025-04-26', 'Initial'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '763'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 303, '2025-05-18', 'Gained 10 kg'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '763'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 284, '2025-04-26', 'Initial'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '764'
WHERE fc.id = 3;
INSERT INTO public.weigh_event (cow_id, weight_kg, weighed_at, notes)
SELECT c.id, 288, '2025-05-18', 'Gained 4 kg'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '764'
WHERE fc.id = 3;

-- Expenses
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-13', 111025, 'EGP', 'SC 2t , B 2t , FF 4t , S 0.25t'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Feed'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-13', 2500, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Food Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-14', 671925, 'EGP', 'First Batch ( 4335kg*155 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cows ( 9 )'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-14', 2500, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cows Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-25', 2340, 'EGP', '250kg'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Straw'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-25', 460, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Ropes'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-03-25', 150, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Straw Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-10', 4400, 'EGP', '500kg'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Straw'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-10', 150, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Straw Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-10', 120, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Netting'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-10', 60, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Wormwood'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 282480, 'EGP', 'Second Batch ( 1712kg*165 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cows ( 4 )'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 52740, 'EGP', 'Second Batch ( 293kg*180 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cow'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 51120, 'EGP', 'Second Batch ( 284kg*180 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cow'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 34560, 'EGP', 'Second Batch Girl ( 192kg*180 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cow'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 36720, 'EGP', 'Second Batch Girl ( 204kg*180 )'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cow'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-26', 2800, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Cows Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-30', 140662, 'EGP', 'FF 7t , YF 1.605t'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Feed'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-04-30', 2800, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Food Transportation'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-05-17', 700, 'EGP', NULL
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Ropes'
WHERE fc.id = 3;
INSERT INTO public.expense (cycle_id, expense_category_id, expense_date, amount, currency_code, description)
SELECT fc.id, ec.id, '2025-05-17', 950, 'EGP', 'Fenbazole 10% , 10 Syringe'
FROM public.farm_cycle fc
JOIN public.expense_category ec ON ec.name = 'Vet'
WHERE fc.id = 3;

-- Sales
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-03-26', 545, 183, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '737'
JOIN public.buyer b ON b.name = 'El Omda'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-01', 604, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '744'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-01', 509, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '742'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-02', 613, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '736'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-02', 565, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '745'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-03', 518, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '743'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-03', 493, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '750'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-04', 499, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '749'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-04', 478, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '751'
JOIN public.buyer b ON b.name = 'Ahmed Maher'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-04', 454, 190, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '752'
JOIN public.buyer b ON b.name = 'Essam El Gawhara'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-05', 593, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '738'
JOIN public.buyer b ON b.name = 'Karam Sabry'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-05', 576, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '741'
JOIN public.buyer b ON b.name = 'Karam Sabry'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-06', 510, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '748'
JOIN public.buyer b ON b.name = 'Youssry El Maghraby'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-06', 331, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '763'
JOIN public.buyer b ON b.name = 'Mr Mahmoud'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-07', 307, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = '764'
JOIN public.buyer b ON b.name = 'Ahmed Hazem'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-07', 212, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = 'Black'
JOIN public.buyer b ON b.name = 'El Omda'
WHERE fc.id = 3;
INSERT INTO public.sale (cow_id, buyer_id, date_sold, weight_at_sale_kg, price_per_kg, currency_code, notes)
SELECT c.id, b.id, '2025-06-07', 233, 185, 'EGP', 'Healthy cow'
FROM public.farm_cycle fc
JOIN public.cow c ON c.cycle_id = fc.id AND c.external_id = 'White'
JOIN public.buyer b ON b.name = 'El Omda'
WHERE fc.id = 3;

-- Feed supply movements
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-04-30', 1000, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-05-01', 2000, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-05-01', 1000, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Bran'
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-05-01', 11000, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-05-01', 1605, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, unit_cost, total_cost, currency_code, expense_id, reference, notes)
SELECT fc.id, fi.id, '2024-05-03', 65, 'supply', NULL, NULL, NULL, NULL, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Hay'
WHERE fc.id = 3;

-- Feed usage movements
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-14', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-14', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-15', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-15', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-16', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-16', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-17', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-17', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-18', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-18', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-19', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-19', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-20', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-20', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-21', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-21', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-22', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-22', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-23', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-23', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-24', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-24', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-25', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-25', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-26', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-26', -108, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-27', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-27', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-28', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-28', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-29', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-29', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-30', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-30', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-31', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-03-31', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-01', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-01', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-02', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-02', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-03', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-03', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-04', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-04', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-05', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-05', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-06', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-06', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-07', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-07', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-08', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-08', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-09', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-09', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-10', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-10', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-11', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-11', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-12', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-12', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-13', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-13', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-14', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-14', -96, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-15', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-15', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-16', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-16', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-17', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-17', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-18', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-18', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-19', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-19', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-20', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-20', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-21', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-21', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-22', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-22', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-23', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-23', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-24', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-24', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-25', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-25', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-26', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-26', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-27', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-28', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-29', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-04-30', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-01', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-02', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-03', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-04', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -17, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-05', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-06', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-07', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -18, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -80, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-08', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-09', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-10', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-11', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-12', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-13', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-14', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-15', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-16', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-17', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-18', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-19', -1.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-20', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-21', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-22', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-23', -1, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-24', -1, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-25', -1, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-26', -1.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-27', -1.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-28', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-29', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-30', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -9, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-05-31', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -16, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -70, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -50, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -6, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -2.5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-01', -2, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Bran'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -14, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -60, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Bran'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-02', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-03', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -10, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -8, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -40, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 2
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -15, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Fattening Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -4, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Straw'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -12, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Young Calf Feed'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 4
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -3, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 3
WHERE fc.id = 3;
INSERT INTO public.feed_ledger (cycle_id, food_item_id, movement_date, qty_kg, movement_type, usage_target_type, group_id, cow_id, notes)
SELECT fc.id, fi.id, '2025-06-04', -5, 'usage', 'group', hg.id, NULL, NULL
FROM public.farm_cycle fc
JOIN public.food_item fi ON fi.name = 'Summer Corn'
JOIN public.herd_group hg ON hg.cycle_id = fc.id AND hg.number = 1
WHERE fc.id = 3;

COMMIT;
