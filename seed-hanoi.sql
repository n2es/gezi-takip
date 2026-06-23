-- Gezi Takip — Hanoi seed (Notion export'undan üretildi, Faz 2)
-- Kaynak: "Hanoi 379e3374b75d800db68cd8d069959151.md" (Notion export)
-- "Ev İlanları" bölümü tamamen atlandı (spec gereği).
-- Onaylandıktan SONRA Supabase SQL Editor'da çalıştır. Toplam: 45 yer.
-- Not: status varsayılan 'todo'. Tabloda zaten test kaydı varsa çift kayıt olabilir.

-- ── Müze (11) ─────────────────────────────────────────────────
insert into places (city, name, category, area, note) values
  ('Hanoi', 'Hoa Lo Prison Museum',                 'museum', NULL,          'Sömürge/savaş hafızası'),
  ('Hanoi', 'Vietnam Museum of Ethnology',          'museum', 'Cau Giay',    'Etnik kültürler'),
  ('Hanoi', 'Vietnam Fine Arts Museum',             'museum', NULL,          'Klasik + modern sanat'),
  ('Hanoi', 'Women''s Museum',                       'museum', NULL,          NULL),
  ('Hanoi', 'Ho Chi Minh Museum',                   'museum', 'Ba Dinh',     'Modern kuruluş anlatısı'),
  ('Hanoi', 'Thang Long Imperial Citadel',          'museum', NULL,          'UNESCO'),
  ('Hanoi', 'National Museum of Vietnamese History','museum', NULL,          NULL),
  ('Hanoi', 'Temple of Literature',                 'museum', NULL,          '1070, Konfüçyüs geleneği'),
  ('Hanoi', 'Hanoi Museum',                         'museum', 'My Dinh',     'Modern'),
  ('Hanoi', 'Manzi Art Space',                      'museum', NULL,          'Çağdaş sanat'),
  ('Hanoi', 'VCCA',                                 'museum', NULL,          'Çağdaş sanat');

-- ── Bölge (6) ─────────────────────────────────────────────────
insert into places (city, name, category, area, note) values
  ('Hanoi', 'Old Quarter / 36 Sokaklar',            'district', NULL,         'Hanoi''nin kalbi'),
  ('Hanoi', 'Tay Ho / West Lake',                   'district', NULL,         'Expat + kafe kültürü'),
  ('Hanoi', 'Truc Bach',                            'district', NULL,         'Göl kenarı, sakin'),
  ('Hanoi', 'French Quarter',                       'district', NULL,         'Opera House, koloniyal mimari'),
  ('Hanoi', 'Dong Xuan Market çevresi',             'district', 'Old Quarter','Sabah erken yerel hayat'),
  ('Hanoi', 'Long Bien Köprüsü + Red River',        'district', NULL,         'Gün batımı yürüyüşü');

-- ── Görülecek (3) ─────────────────────────────────────────────
insert into places (city, name, category, area, note) values
  ('Hanoi', 'Hoan Kiem Gölü + Ngoc Son Tapınağı',   'sight', NULL,           'Tarihî merkez'),
  ('Hanoi', 'Train Street',                         'sight', NULL,           'Ray kenarı kafeler'),
  ('Hanoi', 'Ho Chi Minh Mozolesi + Ba Dinh + One Pillar Pagoda', 'sight', 'Ba Dinh', 'Omuz/diz kapalı');

-- ── Kaçamak (4) ───────────────────────────────────────────────
insert into places (city, name, category, area, note) values
  ('Hanoi', 'Ha Long / Lan Ha Bay',                 'trip', NULL,            'En az 1 gece cruise'),
  ('Hanoi', 'Ninh Binh / Trang An / Tam Coc',       'trip', NULL,            'Karadaki Ha Long'),
  ('Hanoi', 'Sapa',                                 'trip', NULL,            'Opsiyonel — Temmuz yağışlı olabilir'),
  ('Hanoi', 'Quang Phu Cau Tütsü + Chuong Şapka Köyü','trip', NULL,          '~1 saat, yarım gün');

-- ── Yemek (21) ────────────────────────────────────────────────
insert into places (city, name, category, area, note) values
  ('Hanoi', 'Phở Gia Truyền Bát Đàn',               'food', NULL,            'Phở bò'),
  ('Hanoi', 'Phở 10 Lý Quốc Sư',                    'food', NULL,            'Phở bò'),
  ('Hanoi', 'Phở Bò Lâm',                           'food', NULL,            'Phở bò'),
  ('Hanoi', 'Bún Chả Hương Liên',                   'food', NULL,            'Obama/Bourdain etkisi'),
  ('Hanoi', 'Bún Chả Ta',                           'food', NULL,            'Michelin Bib'),
  ('Hanoi', 'Tuyết Bún Chả 34',                     'food', NULL,            'Daha yerel'),
  ('Hanoi', 'Bánh Cuốn Gia Truyền Thanh Vân',       'food', NULL,            'Bánh cuốn'),
  ('Hanoi', 'Chả Cá Thăng Long',                    'food', NULL,            'Chả cá'),
  ('Hanoi', 'Chả Cá Lã Vọng',                       'food', NULL,            'Chả cá (klasik marka)'),
  ('Hanoi', 'Xôi Yến',                              'food', NULL,            'Xôi (yapışkan pirinç)'),
  ('Hanoi', 'Bún Thang Cầu Gỗ',                     'food', NULL,            'Bún thang'),
  ('Hanoi', 'Miến Lươn Chân Cầm',                   'food', NULL,            'Yılan balıklı noodle'),
  ('Hanoi', 'Cafe Giang',                           'food', NULL,            'Egg coffee'),
  ('Hanoi', 'Cafe Dinh',                            'food', NULL,            'Egg coffee'),
  ('Hanoi', 'Cong Ca Phe',                          'food', NULL,            'Coconut coffee'),
  ('Hanoi', 'Chè Bà Thìn',                          'food', NULL,            'Chè (tatlı)'),
  ('Hanoi', 'Kem Tràng Tiền',                       'food', 'Opera House',   'Klasik dondurma'),
  ('Hanoi', 'Home Hanoi Restaurant',                'food', NULL,            'Rafine akşam yemeği'),
  ('Hanoi', 'Ngon Villa',                           'food', NULL,            'Rafine akşam yemeği'),
  ('Hanoi', 'T.U.N.G Dining',                       'food', NULL,            'Modern mutfak'),
  ('Hanoi', 'Ta Hien (Bia Hơi Sokağı)',             'food', NULL,            'Bia hơi kültürü');
