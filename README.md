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

### Boîtes colorées

Trois boîtes thématiques sont disponibles, chacune avec une couleur par défaut  
modifiable via un argument optionnel.

#### `\begin{retenir}[couleur] ... \end{retenir}`

Boîte « À retenir absolument » — couleur par défaut : **bleu**.

```latex
\begin{retenir}
    Le théorème de Pythagore : $a^2 + b^2 = c^2$
\end{retenir}
\begin{retenir}[orange]
    Version personnalisée en orange.
\end{retenir}
```

##### `\begin{vigilance}[couleur] ... \end{vigilance}`

Boîte « Attention ! » — couleur par défaut : **rouge**.

Boîte « Attention ! » — couleur par défaut : **rouge**.

```latex
\begin{vigilance}
    Ne pas oublier de vérifier les unités !
\end{vigilance}
\begin{vigilance}[purple]
    Version personnalisée en violet.
\end{vigilance}
```

##### `\begin{methode}[couleur] ... \end{methode}`

```latex
\begin{methode}
    1. Identifier les données \\
    2. Choisir la formule \\
    3. Calculer
\end{methode}
```

#### `\boitecalcul[largeur][hauteur]{contenu} `

**Paramètres optionnels :**

| Argument | Description | Défaut |
|----------|-------------|--------|
| `largeur` | Largeur de la boîte | `10cm` |
| `hauteur` | Hauteur de la boîte | `3cm` |

## LICENCE

MIT

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