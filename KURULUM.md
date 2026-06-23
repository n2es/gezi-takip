# Gezi Takip — Kurulum

Bir şehirdeki gezilecek yerleri takip etmek için basit bir uygulama. Eşinle ortak,
tek bir paylaşımlı Supabase tablosu; login yok.

## 1. Supabase veritabanını kur (tek seferlik, ~5 dakika)

1. https://supabase.com → **New project** (Bölge: Southeast Asia / Singapore önerilir).
2. Sol menüden **SQL Editor → New query** → aşağıdaki SQL'i yapıştır → **Run**:

```sql
create table places (
  id          uuid primary key default gen_random_uuid(),
  city        text not null default 'Hanoi',
  name        text not null,
  category    text,                          -- museum | district | sight | trip | food
  area        text,
  note        text,
  status      text not null default 'todo',  -- todo | done
  visited_at  timestamptz,
  place_id    text,                          -- Faz 3 (enrichment) için, şimdilik boş
  created_at  timestamptz default now()
);

alter table places enable row level security;

create policy "herkes okur yazar" on places
  for all using (true) with check (true);

-- Şehirler (ülkeye göre gruplanan ana ekran listesi)
create table cities (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  country     text not null,
  created_at  timestamptz default now()
);

alter table cities enable row level security;

create policy "herkes okur yazar" on cities
  for all using (true) with check (true);

-- İlk şehir
insert into cities (name, country) values ('Hanoi', 'Vietnam');
```

3. **Project Settings → API** bölümünden şu ikisini kopyala:
   - **Project URL** (örn. `https://abcdefgh.supabase.co`)
   - API anahtarı: **anon / publishable** (`eyJ...` veya `sb_publishable_...`). **Secret/service_role anahtarını kullanma.**

## 2. Uygulamayı telefonlara kur

1. iPhone'da Safari ile aç: **https://n2es.github.io/gezi-takip/**
2. Açılan **Kurulum** ekranına URL ve anahtarı yapıştır → **Bağlan ve test et**.
3. Safari **Paylaş → Ana Ekrana Ekle**.
4. Aynısını eşinin telefonunda da yap. İkiniz de aynı listeyi görür ve işaretlersiniz.

## Kullanım

- **Liste (ana ekran):** Üstte şehir (Hanoi). Çiplerle filtrele: durum (Gezilecek / Gezildi / Hepsi) ve kategori. Bir yere dokununca anında "gezildi ✓" olur, tekrar dokununca geri alınır — değişiklik anında kaydedilir ve eşinde de görünür. En altta "X/Y gezildi" özeti.
- **＋ Yer ekle:** Ad (zorunlu), kategori, semt ve not. Kaydet → listeye döner.

## Notlar

- Kategoriler: Müze, Bölge, Görülecek, Kaçamak, Yemek. Liste bunlara göre gruplanır.
- Bağlantı yoksa işaretleme geri alınır ve uyarı gösterilir (yanlış veri kalmaz).
- İçerik şu an **Hanoi** içindir; ileride başka şehirler eklenebilir (`city` alanı hazır).
