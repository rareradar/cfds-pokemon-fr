# cfds-pokemon-fr

Site Jekyll de **RareRadar** — reviews et guides éditoriaux sur les cartes
Pokémon TCG pour collectionneurs francophones adultes.

Production déployée sur **GitHub Pages** + custom domain OVH : <https://rareradar.fr>

---

## Stack

- **Jekyll 4.3** (build natif GitHub Pages)
- Plugins : `jekyll-feed`, `jekyll-seo-tag`, `jekyll-sitemap`
- Thème : custom (CSS dans `assets/css/style.css`)
- Layouts : `_layouts/{default,home,post}.html`
- Includes : `_includes/{header,footer,article-card,rarity-badge}.html`
- Données : `_data/rarity.yml` (système de "rareté éditoriale")
- Covers articles : générées via `scripts/cfds_generate_cover.py` (PIL),
  stockées dans `assets/images/posts/<slug>.png`, référencées via
  front matter `cover_image:`

## Articles

Les articles sont des fichiers Markdown dans `_posts/<YYYY-MM-DD>-<slug>.md`.
Front matter type :

```yaml
---
layout: post
title: "..."
description: "Meta SEO ≤ 160 caractères"
date: 2026-05-05 09:00:00 +0200
slug: kebab-case
rarity: holo_rare    # common | uncommon | holo_rare | secret_rare
read_time: 9
cover_image: /assets/images/posts/<slug>.png
tags: [accessoires, classeurs]
---
```

## Local dev

```bash
bundle install
bundle exec jekyll serve
# → http://127.0.0.1:4000/
```

## Build & déploiement

GitHub Pages build automatiquement à chaque push sur `main`. Aucun workflow
GitHub Actions à configurer.

## Génération de cover

```bash
# Depuis un post existant (slug + rarity lus dans le front matter)
python3 scripts/cfds_generate_cover.py --from-post cfds-site/_posts/<file>.md \
  --number 001 --tag "META · LANCEMENT"

# Manuellement
python3 scripts/cfds_generate_cover.py mon-slug \
  --rarity holo_rare --number 042 --title "Titre court" --tag "DOSSIER"
```

Sortie : 1200×675 PNG dans `cfds-site/assets/images/posts/<slug>.png`.

---

*Pas de contenu commercial déguisé. Les recommandations sont éditoriales ;
les liens partenaires éventuels sont signalés en clair sur chaque article.*
