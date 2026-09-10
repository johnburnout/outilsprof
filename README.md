# outilsprof

Package LaTeX d'outils pour l'enseignement (collège).

## Auteur

Jean Roussie — Collège La Boétie, Sarlat (Dordogne)

## Installation

### Installation locale (recommandée)

1. Copiez `outilsprof.sty` dans `~/Library/texmf/tex/latex/outilsprof/` (macOS)
   ou dans `~/texmf/tex/latex/outilsprof/` (Linux)
2. Lancez `texhash ~/Library/texmf` (ou `mktexlsr`)
3. Dans votre document : `\usepackage{outilsprof}`

### Installation globale

Placez `outilsprof.sty` dans un dossier reconnu par TeX Live, puis lancez `texhash`.

## Commandes disponibles

### `\axegradue`

Trace un axe gradué avec TikZ.

**Paramètres nommés :**

| Clé | Description | Défaut |
|-----|-------------|--------|
| `longueur` | Largeur relative (0.8 = 80% de `\textwidth`) | `1` |
| `debut` | Début de la graduation | `0` |
| `fin` | Fin de la graduation | `100` |
| `pas` | Pas entre nombres repères | `10` |
| `nombre` | Nombre de sous-intervalles | `2` |
| `points` | Points `{A/120, B/340/blue}` | vide |

**Exemples :**

```latex
\axegradue
\axegradue[longueur=0.8, fin=400, pas=100, nombre=5]
\axegradue[debut=100, fin=500, pas=100, nombre=5]
\axegradue[points={A/120, B/340/blue, C/60/green}]
```
**Syntaxe des points :**

-nom/position → intérieur rouge, étiquette noire
-nom/position/couleur → intérieur de la couleur, étiquette noire

```latex
\axegraduepoints
```

Variante avec les points en argument obligatoire.

```latex
\axegraduepoints[longueur=0.8, fin=400, pas=100, nombre=5]{A/120, B/340/blue}
```

**LICENCE**

MIT
