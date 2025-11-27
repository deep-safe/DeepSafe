alter table profiles
add column province_scores jsonb default '{}'::jsonb;
