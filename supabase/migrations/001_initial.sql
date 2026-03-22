-- Create profiles table
create table if not exists profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text unique not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create cheeses table
create table if not exists cheeses (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  type text not null,
  origin text,
  description text,
  image_url text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create tasting_logs table
create table if not exists tasting_logs (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade not null,
  cheese_id uuid references cheeses on delete cascade not null,
  rating integer check (rating >= 1 and rating <= 5),
  notes text,
  tasted_at timestamp with time zone default timezone('utc'::text, now()) not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create wishlist table
create table if not exists wishlist (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade not null,
  cheese_id uuid references cheeses on delete cascade not null,
  added_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(user_id, cheese_id)
);

-- Create RLS policies
alter table profiles enable row level security;
alter table tasting_logs enable row level security;
alter table wishlist enable row level security;

-- Profiles policies
create policy "Users can view own profile" on profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);
create policy "Users can insert own profile" on profiles for insert with check (auth.uid() = id);

-- Tasting logs policies
create policy "Users can view own tasting logs" on tasting_logs for select using (auth.uid() = user_id);
create policy "Users can insert own tasting logs" on tasting_logs for insert with check (auth.uid() = user_id);
create policy "Users can update own tasting logs" on tasting_logs for update using (auth.uid() = user_id);
create policy "Users can delete own tasting logs" on tasting_logs for delete using (auth.uid() = user_id);

-- Wishlist policies
create policy "Users can view own wishlist" on wishlist for select using (auth.uid() = user_id);
create policy "Users can insert into own wishlist" on wishlist for insert with check (auth.uid() = user_id);
create policy "Users can delete from own wishlist" on wishlist for delete using (auth.uid() = user_id);

-- Cheeses are public for reading
create policy "Anyone can view cheeses" on cheeses for select using (true);

-- Function to handle new user profile creation
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$$;

-- Trigger for new user profile creation
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Insert some sample cheeses
insert into cheeses (name, type, origin, description) values
('Aged Cheddar', 'Hard', 'England', 'Sharp, tangy flavor with a firm texture'),
('Brie de Meaux', 'Soft', 'France', 'Creamy, buttery texture with a mild, earthy flavor'),
('Parmigiano-Reggiano', 'Hard', 'Italy', 'Nutty, fruity flavor with a granular texture'),
('Goat Cheese', 'Fresh', 'Various', 'Tangy, creamy cheese made from goat milk'),
('Blue Roquefort', 'Blue', 'France', 'Strong, sharp flavor with distinctive blue veining'),
('Manchego', 'Semi-Hard', 'Spain', 'Nutty, sweet flavor with a firm texture'),
('Camembert', 'Soft', 'France', 'Creamy interior with a white, bloomy rind'),
('Gruyère', 'Hard', 'Switzerland', 'Sweet, nutty flavor that becomes more complex with age');