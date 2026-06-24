#!/usr/bin/env python3
"""
Notion CSV export -> gezi-takip guides.js verisi.

Kullanım:
    python3 tools/csv-to-guides.py export.csv            # ekrana yaz (kopyala)
    python3 tools/csv-to-guides.py export.csv > guides.js  # doğrudan guides.js'e yaz

CSV kolonları (Notion property adları, sıra önemsiz, büyük/küçük harf toleranslı):
    Name, Category, Area, Priority, Note, Maps URL, Guide, City, Country, Order

Kurallar:
  - Category yalnızca: Müze | Simge | Bölge | Yeme-İçme | Günübirlik  (değilse satır ATLANIR + uyarı)
  - Priority yalnızca: Mutlaka Gör | Vakit Varsa | Alternatif  (boş olabilir; geçersizse boşaltılır + uyarı)
  - visited her zaman false
  - Maps URL / Note eksikse boş string
  - Order varsa liste sırası için kullanılır (yoksa ada göre)
  - Guide = katman (tier). Bir yer en düşük ait olduğu katmanla etiketlenir;
    CUMULATIVE=True ise üst katmanlara otomatik eklenir (express -> essential, large).
    Çoklu değer için virgülle ayır (Notion multi-select): "express, essential"
"""

import csv
import json
import sys
from collections import OrderedDict, defaultdict

# ── Ayarlanabilir ─────────────────────────────────────────────
TIER_ORDER = ["express", "essential", "large"]  # küçükten büyüğe (isimler değişebilir)
CUMULATIVE = True  # True: alt katman üst katmanlara otomatik dahil olur

CATEGORIES = {"Müze", "Simge", "Bölge", "Yeme-İçme", "Günübirlik"}
PRIORITIES = {"Mutlaka Gör", "Vakit Varsa", "Alternatif"}

warnings = []


def col(row, *names):
    """Esnek kolon eşleştirme (başlık adı / boşluk / büyük-küçük harf toleranslı)."""
    for n in names:
        for k in row:
            if k and k.strip().lower() == n.lower():
                return (row[k] or "").strip()
    return ""


def expand_tiers(raw_guide):
    """Guide hücresini katman kümesine çevirir; CUMULATIVE ise üst katmanları ekler."""
    tags = [t.strip().lower() for t in raw_guide.split(",") if t.strip()]
    result = set()
    for t in tags:
        if t in TIER_ORDER and CUMULATIVE:
            for higher in TIER_ORDER[TIER_ORDER.index(t):]:
                result.add(higher)
        else:
            result.add(t)
    return result


def main():
    if len(sys.argv) < 2:
        sys.exit("Kullanım: python3 tools/csv-to-guides.py <export.csv>")
    path = sys.argv[1]

    # (city, country) -> tier -> [ (order, place_dict) ]
    bucket = OrderedDict()

    with open(path, encoding="utf-8-sig", newline="") as f:
        for i, raw in enumerate(csv.DictReader(f), start=2):  # 1 = başlık
            name = col(raw, "Name")
            if not name:
                continue
            category = col(raw, "Category")
            if category not in CATEGORIES:
                warnings.append(f"Satır {i} ({name}): geçersiz Category '{category}' — atlandı")
                continue
            city, country = col(raw, "City"), col(raw, "Country")
            if not city or not country:
                warnings.append(f"Satır {i} ({name}): City/Country eksik — atlandı")
                continue
            priority = col(raw, "Priority")
            if priority and priority not in PRIORITIES:
                warnings.append(f"Satır {i} ({name}): geçersiz Priority '{priority}' — boşaltıldı")
                priority = ""
            order_raw = col(raw, "Order")
            try:
                order_n = int(float(order_raw)) if order_raw else 10 ** 9
            except ValueError:
                order_n = 10 ** 9
                warnings.append(f"Satır {i} ({name}): Order sayı değil — sona alındı")
            guide_raw = col(raw, "Guide")
            tiers = expand_tiers(guide_raw)
            if not tiers:
                tiers = {TIER_ORDER[-1]}  # Guide boşsa en geniş katmana koy
                warnings.append(f"Satır {i} ({name}): Guide boş — '{TIER_ORDER[-1]}' varsayıldı")

            place = OrderedDict([
                ("name", name),
                ("category", category),
                ("area", col(raw, "Area")),
                ("priority", priority),
                ("note", col(raw, "Note")),
                ("mapsUrl", col(raw, "Maps URL", "MapsURL", "Maps Url")),
                ("visited", False),
            ])
            key = (city, country)
            bucket.setdefault(key, defaultdict(list))
            for t in tiers:
                bucket[key][t].append((order_n, place))

    # guides dizisini kur (TIER_ORDER sırası, sonra bilinmeyen tier'lar)
    guides = []
    for (city, country), tiers in bucket.items():
        ordered = [t for t in TIER_ORDER if t in tiers] + \
                  [t for t in tiers if t not in TIER_ORDER]
        for tier in ordered:
            items = sorted(tiers[tier], key=lambda x: (x[0], x[1]["name"].lower()))
            guides.append(OrderedDict([
                ("city", city),
                ("country", country),
                ("guide", tier),
                ("title", f"{city} — {tier.capitalize()}"),
                ("places", [p for _, p in items]),
            ]))

    body = json.dumps(guides, ensure_ascii=False, indent=2)
    print("window.GUIDES = " + body + ";")

    # Özet + uyarılar stderr'e (çıktıyı kirletmez)
    sys.stderr.write(f"\n✓ {len(guides)} rehber, "
                     f"{sum(len(g['places']) for g in guides)} yer "
                     f"(kümülatif={CUMULATIVE}).\n")
    by_city = defaultdict(list)
    for g in guides:
        by_city[g["city"]].append(f"{g['guide']}({len(g['places'])})")
    for city, tlist in by_city.items():
        sys.stderr.write(f"  {city}: {', '.join(tlist)}\n")
    if warnings:
        sys.stderr.write("\nUYARILAR:\n" + "\n".join("  - " + w for w in warnings) + "\n")


if __name__ == "__main__":
    main()
