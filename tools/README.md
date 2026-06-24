# Rehber Hattı — Notion CSV → guides.js

Şehir rehberlerini Notion'da hazırla, CSV olarak dışa aktar, bu araçla `guides.js`
verisine çevir. Elle JSON yazmana gerek yok.

## 1. Notion tablosu (database)

Şu kolonlarla bir tablo kur (property adları birebir önemli değil, araç toleranslı):

| Kolon | Açıklama |
|---|---|
| **Name** | Yer adı (zorunlu) |
| **Category** | Yalnızca: `Müze` `Simge` `Bölge` `Yeme-İçme` `Günübirlik` |
| **Area** | Semt/bölge (opsiyonel) |
| **Priority** | Yalnızca: `Mutlaka Gör` `Vakit Varsa` `Alternatif` (opsiyonel) |
| **Note** | Kısa not (opsiyonel) |
| **Maps URL** | Google Maps linki (opsiyonel) |
| **Guide** | Katman: `express` `essential` `large`. Yeri **en düşük** ait olduğu katmanla etiketle |
| **City** | Şehir (örn. `Da Nang`) |
| **Country** | Ülke (örn. `Vietnam`) |
| **Order** | Liste sırası (sayı) |

**Katman mantığı (kümülatif):** `express` etiketli bir yer otomatik olarak `essential`
ve `large` rehberlerine de girer. Yani her yeri **bir kez** etiketlersin; araç katlar.
(Bağımsız katman istersen `csv-to-guides.py` içindeki `CUMULATIVE = False` yap.)

Örnek dosya: [`ornek-rehber.csv`](ornek-rehber.csv)

## 2. CSV dışa aktar

Notion'da tablo görünümünde **··· → Export → CSV** (markdown değil).

## 3. guides.js verisine çevir

```bash
python3 tools/csv-to-guides.py export.csv > guides.js
```

- Ekrana özet + uyarı yazar (geçersiz Category/Priority satırlarını söyler).
- `guides.js` doğrudan üretilir; commit + deploy edince "Rehberden Oluştur"da görünür.

## Kurallar (araç otomatik uygular)

- Geçersiz **Category** → satır atlanır (uyarı verir).
- Geçersiz **Priority** → boşaltılır (yer kalır).
- **visited** her zaman `false`.
- Eksik **Maps URL / Note** → boş string.
- **Order** varsa sıralama ona göre, yoksa ada göre.
- Var olan şehir/yer verisine dokunmaz (bu yalnızca guides.js üretir).

## Pratik akış

Notion'da rehberi hazırla → CSV'yi bana ver → ben çevirip `guides.js`'i güncelleyip
deploy edeyim (Hanoi importunda yaptığımız gibi). İstersen yukarıdaki komutu kendin de
çalıştırabilirsin.

> Not: Katman **satın alma** (IAP) native store sürümünün işi; PWA'da çalışmaz.
> Bu hat içeriği hazırlar, satın alma kapısı store sürümüyle eklenir.
