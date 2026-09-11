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

- [`\axegradue` et `\axegraduepoints`](#axegradue) — axe gradué horizontal
- [`\reperegradue` et `\reperegraduepoints`](#reperegradue) — repère orthogonal gradué
- [Boîtes colorées](#boîtes-colorées) — mise en valeur pédagogique

---

## `\axegradue`

Trace un axe gradué horizontal avec TikZ.

### Paramètres nommés

| Clé | Description | Défaut |
|-----|-------------|--------|
| `longueur` | Largeur relative (0.8 = 80% de `\textwidth`) | `0.8` |
| `debut` | Début de la graduation | `0` |
| `fin` | Fin de la graduation | `100` |
| `pas` | Pas entre nombres repères | `10` |
| `nombre` | Nombre de sous-intervalles entre repères | `2` |
| `points` | Liste `{A/120, B/340/blue}` | vide |

### Exemples

```latex
\axegradue
\axegradue[longueur=0.8, fin=400, pas=100, nombre=5]
\axegradue[debut=100, fin=500, pas=100, nombre=5]
\axegradue[points={A/120, B/340/blue, C/60/green}]
```

### Syntaxe des points

- `nom/position` → intérieur rouge, étiquette noire
- `nom/position/couleur` → intérieur de la couleur, étiquette noire

### `\axegraduepoints`

Variante avec les points en argument obligatoire.

```latex
\axegraduepoints[longueur=0.8, fin=400, pas=100, nombre=5]{A/120, B/340/blue}
```

---

## `\reperegradue`

Trace un repère orthogonal gradué avec TikZ.

### Paramètres nommés

| Clé | Description | Défaut |
|-----|-------------|--------|
| `longueur` | Largeur relative (0.8 = 80% de `\textwidth`) | `0.8` |
| `bg` | Coin bas-gauche `(x,y)` | `{(-10,-10)}` |
| `hd` | Coin haut-droit `(x,y)` | `{(10,10)}` |
| `origine` | Intersection des axes `(x,y)` | `{(0,0)}` |
| `grille` | Pas de la grille fine (0 = pas de grille) | `1` |
| `pasx` | Pas entre repères sur l'axe des abscisses | `1` |
| `pasy` | Pas entre repères sur l'axe des ordonnées | `1` |
| `nombrex` | Nb de sous-intervalles entre repères (x) | `1` |
| `nombrey` | Nb de sous-intervalles entre repères (y) | `1` |
| `points` | Liste `{A/(4,5), B/(-2,3)/blue}` | vide |
| `affichernom` | Afficher le nom du point | `true` |
| `affichercoords` | Afficher les coordonnées du point | `false` |

### Remarque importante

Les valeurs de `bg`, `hd` et `origine` contiennent une virgule.
**Elles doivent être protégées par des accolades**, sinon `l3keys`
interprète la virgule comme un séparateur de clés :

```latex
% ❌ Ne fonctionne pas
\reperegradue[bg=(-5,-5), hd=(5,5)]

% ✅ Correct
\reperegradue[bg={(-5,-5)}, hd={(5,5)}]
```

La liste `points` **n'a pas besoin** de cette protection : la virgule
interne aux parenthèses est automatiquement détectée et protégée par
le package.

### Exemples

```latex
% Repère par défaut : fenêtre [-10,10]×[-10,10], grille de 1
\reperegradue

% Fenêtre plus petite
\reperegradue[bg={(-5,-5)}, hd={(5,5)}, grille=1]

% Fenêtre avec grille plus fine
\reperegradue[bg={(-4,-2)}, hd={(3,6)}, grille=0.5]

% Origine décalée
\reperegradue[bg={(-5,-5)}, hd={(5,5)}, origine={(2,3)}]

% Grille désactivée
\reperegradue[grille=0]

% Graduations principales personnalisées
\reperegradue[bg={(-10,-10)}, hd={(10,10)}, pasx=2, pasy=2]
\reperegradue[bg={(-10,-10)}, hd={(10,10)},
              pasx=5, pasy=5, nombrex=5, nombrey=5]

% Repère avec points, syntaxe naturelle
\reperegradue[points={A/(4,5), B/(-2,3)/blue, C/(1,-2)/green}]

% Repère avec coordonnées affichées sous les noms
\reperegradue[points={A/(4,5), B/(-2,3)/blue},
              affichernom=true, affichercoords=true]

% Repère sans nom mais avec coordonnées
\reperegradue[points={A/(4,5), B/(-2,3)/blue},
              affichernom=false, affichercoords=true]

% Repère avec points seulement (aucune étiquette)
\reperegradue[points={A/(4,5), B/(-2,3)/blue},
              affichernom=false, affichercoords=false]
```

### Syntaxe des points

- `nom/(x,y)` → intérieur rouge (défaut), étiquette noire
- `nom/(x,y)/couleur` → intérieur de la couleur spécifiée

La couleur peut être n'importe quelle couleur TikZ, y compris les
couleurs composées (`orange!80!black`, `red!70`, etc.).

### Étiquette de l'intersection des axes

Le package affiche automatiquement l'étiquette appropriée au point
d'intersection des axes :

- Si l'origine est `(0,0)` → affiche **O**
- Sinon → affiche **Ω(a;b)** où `a` et `b` sont les coordonnées de
  l'intersection

```latex
\reperegradue                              % → affiche "O"
\reperegradue[origine={(2,3)}]             % → affiche "Ω(2;3)"
\reperegradue[origine={(-2,-3)}]           % → affiche "Ω(-2;-3)"
\reperegradue[origine={(0,3)}]             % → affiche "Ω(0;3)"
```

### `\reperegraduepoints`

Variante avec les points en argument obligatoire.

```latex
\reperegraduepoints[bg={(-5,-5)}, hd={(5,5)}]{A/(2,3), B/(-1,-2)/orange}
```

---

## Boîtes colorées

Trois boîtes thématiques sont disponibles, chacune avec une couleur par
défaut modifiable via un argument optionnel.

### `\begin{retenir}[couleur] ... \end{retenir}`

Boîte « À retenir absolument » — couleur par défaut : **bleu**.

```latex
\begin{retenir}
    Le théorème de Pythagore : $a^2 + b^2 = c^2$.
\end{retenir}

\begin{retenir}[orange]
    Version personnalisée en orange.
\end{retenir}
```

### `\begin{vigilance}[couleur] ... \end{vigilance}`

Boîte « Attention ! » — couleur par défaut : **rouge**.

```latex
\begin{vigilance}
    Ne pas oublier de vérifier les unités !
\end{vigilance}

\begin{vigilance}[purple]
    Version personnalisée en violet.
\end{vigilance}
```

### `\begin{methode}[couleur] ... \end{methode}`

Boîte « Méthode de résolution » — couleur par défaut : **vert**.

```latex
\begin{methode}
    1. Identifier les données \\
    2. Choisir la formule \\
    3. Calculer
\end{methode}
```

### Commandes équivalentes

Les mêmes boîtes sont accessibles sous forme de commandes :

```latex
\boiteRetenir{Contenu}
\boiteRetenir[orange]{Contenu personnalisé}

\boiteVigilance{Contenu}
\boiteVigilance[purple]{Contenu personnalisé}

\boiteMethode{Contenu}
\boiteMethode[cyan]{Contenu personnalisé}
```

### `\boitecalcul[largeur][hauteur]{contenu}`

Boîte neutre pour les calculs, centrée horizontalement et verticalement.

**Paramètres optionnels :**

| Argument | Description | Défaut |
|----------|-------------|--------|
| largeur  | Largeur de la boîte | `10cm` |
| hauteur  | Hauteur de la boîte | `3cm`  |

```latex
\boitecalcul{$2 + 2 = 4$}
\boitecalcul[8cm][4cm]{$\frac{3}{4} + \frac{1}{2} = \frac{5}{4}$}
```

### Couleurs par défaut

Les couleurs par défaut sont définies et peuvent être redéfinies dans le
préambule du document :

```latex
\definecolor{couleurRetenir}{RGB}{0,102,204}    % Bleu
\definecolor{couleurVigilance}{RGB}{204,0,0}    % Rouge
\definecolor{couleurMethode}{RGB}{0,153,76}     % Vert
```

---

## Exemples

Un fichier de démonstration complet est disponible dans
`examples/exemples.tex`. Pour le compiler :

```bash
cd examples
pdflatex exemples.tex
```

---

## Aide-mémoire rapide

```latex
% Axe gradué
\axegradue[fin=400, pas=100, nombre=5, points={A/120, B/340/blue}]

% Repère par défaut
\reperegradue

% Repère personnalisé avec points
\reperegradue[
    bg={(-6,-6)}, hd={(6,6)},
    origine={(0,0)},
    grille=1,
    pasx=1, pasy=1,
    nombrex=1, nombrey=1,
    points={A/(4,5), B/(-2,3)/blue, C/(1,-2)/green},
    affichernom=true,
    affichercoords=false
]

% Boîtes
\begin{retenir}[bleu] ... \end{retenir}
\begin{vigilance}[rouge] ... \end{vigilance}
\begin{methode}[vert] ... \end{methode}
\boitecalcul[8cm][4cm]{...}
```

---

## Licence

MIT