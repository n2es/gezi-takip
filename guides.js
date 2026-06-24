// ── Şehir Rehberleri ──────────────────────────────────────────
// Buraya yeni şehir rehberleri eklenir; uygulama "Rehberden Oluştur"
// ekranında bunları listeler ve seçilince şehri + yerleri otomatik kurar.
//
// Alanlar:
//   city     : şehir adı (örn. "Da Nang")
//   country  : ülke (örn. "Vietnam")
//   title    : rehber başlığı (opsiyonel, gösterim için)
//   places[] : yerler. Her yer için:
//     name     : yer adı (zorunlu)
//     category : Müze | Simge | Bölge | Yeme-İçme | Günübirlik
//     area     : semt/mahalle/bölge (opsiyonel)
//     priority : Mutlaka Gör | Vakit Varsa | Alternatif (opsiyonel)
//     note     : kısa açıklama/not (opsiyonel)
//     mapsUrl  : Google Maps linki (opsiyonel)
//     visited  : true | false (varsayılan false)
//
// ÖNEMLİ: Hanoi verisi veritabanında ZATEN var — buraya Hanoi EKLEME
// (aynı isimli şehir tekrar eklenmez, "zaten ekli" uyarısı çıkar).
//
// Örnek (kopyalayıp doldurabilirsin):
// {
//   city: "Da Nang", country: "Vietnam", title: "Da Nang Rehberi",
//   places: [
//     { name: "My Khe Beach", category: "Simge", area: "Son Tra",
//       priority: "Mutlaka Gör", note: "Şehir plajı", mapsUrl: "", visited: false }
//   ]
// }

window.GUIDES = [
];
