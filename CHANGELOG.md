
## CHANGELOG.md

```markdown
# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/)
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [1.1] - 2026-09-11

### Ajouté
- Boîtes colorées pour la mise en valeur pédagogique :
  - Environnement `retenir` (bleu par défaut) et commande `\boiteRetenir`
  - Environnement `vigilance` (rouge par défaut) et commande `\boiteVigilance`
  - Environnement `methode` (vert par défaut) et commande `\boiteMethode`
  - Commande `\boitecalcul` avec dimensions réglables
- Couleurs par défaut personnalisables : `couleurRetenir`, `couleurVigilance`,
  `couleurMethode`
- Chaque boîte accepte un argument optionnel pour changer sa couleur

### Modifié
- Ajout des dépendances `tcolorbox` et de sa librairie `skins`

## [1.0] - 2026-09-10

### Ajouté
- Première version de `\axegradue`
- Variante `\axegraduepoints`