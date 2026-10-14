-- Caderneta de Estádio: estrutura do banco no Supabase.
-- Rode tudo de uma vez em Supabase → SQL Editor → New query → Run.
-- Pode rodar de novo sem problema: nada é apagado.

-- 1. Jogos
create table if not exists public.matches (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date        date not null,
  home        text not null,
  away        text not null,
  hg          integer not null default 0 check (hg >= 0),
  ag          integer not null default 0 check (ag >= 0),
  comp        text,
  stadium     text,
  city        text,
  country     text,
  att         integer,
  rating      integer check (rating between 0 and 5),
  with_who    text,
  notes       text,
  cover_path  text,
  created_at  timestamptz not null default now()
);
create index if not exists matches_user_date on public.matches (user_id, date);

-- 2. Perfil
create table if not exists public.profiles (
  user_id     uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  name        text,
  my_team     text,
  avatar_path text,
  updated_at  timestamptz not null default now()
);

-- 3. Escudos dos clubes (um por clube, por usuário)
create table if not exists public.club_logos (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  club_key   text not null,
  name       text,
  url        text,
  path       text,
  source     text not null default 'auto' check (source in ('auto','manual','none')),
  updated_at timestamptz not null default now(),
  primary key (user_id, club_key)
);

-- 4. Segurança: cada pessoa só enxerga e altera os próprios dados
alter table public.matches    enable row level security;
alter table public.profiles   enable row level security;
alter table public.club_logos enable row level security;

drop policy if exists "dono dos jogos"   on public.matches;
drop policy if exists "dono do perfil"   on public.profiles;
drop policy if exists "dono dos escudos" on public.club_logos;

create policy "dono dos jogos" on public.matches
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "dono do perfil" on public.profiles
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "dono dos escudos" on public.club_logos
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

-- 5. Fotos (capas, perfil e escudos enviados): pasta privada por usuário
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('fotos', 'fotos', false, 10485760, array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do nothing;

drop policy if exists "fotos: ler as minhas"     on storage.objects;
drop policy if exists "fotos: enviar as minhas"  on storage.objects;
drop policy if exists "fotos: trocar as minhas"  on storage.objects;
drop policy if exists "fotos: apagar as minhas"  on storage.objects;

create policy "fotos: ler as minhas" on storage.objects for select to authenticated
  using (bucket_id = 'fotos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "fotos: enviar as minhas" on storage.objects for insert to authenticated
  with check (bucket_id = 'fotos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "fotos: trocar as minhas" on storage.objects for update to authenticated
  using (bucket_id = 'fotos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "fotos: apagar as minhas" on storage.objects for delete to authenticated
  using (bucket_id = 'fotos' and (storage.foldername(name))[1] = auth.uid()::text);
