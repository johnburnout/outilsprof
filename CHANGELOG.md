# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/)
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [1.2] - 2026-09-11

### Ajouté
- Boîtes colorées pour la mise en valeur pédagogique :
  - Environnement `retenir` (bleu par défaut) et commande `\boiteRetenir`
  - Environnement `vigilance` (rouge par défaut) et commande `\boiteVigilance`
  - Environnement `methode` (vert par défaut) et commande `\boiteMethode`
  - Commande `\boitecalcul` avec dimensions réglables
- Couleurs par défaut personnalisables : `couleurRetenir`, `couleurVigilance`,
  `couleurMethode`
- Chaque boîte accepte un argument optionnel pour changer sa couleur
- Nouvelle commande `\reperegradue` : trace un repère orthogonal gradué
  avec TikZ
  - Fenêtre rectangulaire personnalisable via `bg` et `hd`
  - Position de l'intersection des axes personnalisable via `origine`
  - Grille fine optionnelle via `grille`
  - Graduations principales et secondaires indépendantes sur chaque axe
    (`pasx`, `pasy`, `nombrex`, `nombrey`)
  - Placement de points avec syntaxe naturelle
    `points={A/(4,5), B/(-2,3)/blue, C/(1,-2)/green}`
    (les virgules internes aux parenthèses sont automatiquement protégées)
- Nouvelle commande `\reperegraduepoints` : variante de `\reperegradue` avec
  les points en argument obligatoire
- Étiquette dynamique au point d'intersection des axes :
  - `O` si l'origine est `(0,0)`
  - `Ω(a;b)` sinon, avec les coordonnées de l'intersection
- Nouvelles options pour les étiquettes de points :
  - `affichernom` (booléen, `true` par défaut) : afficher le nom du point
  - `affichercoords` (booléen, `false` par défaut) : afficher les coordonnées
    du point sous la forme `(x;y)`

### Modifié
- Section 1-B du package : `\reperegradue` bénéficie de toutes les
  améliorations issues des tests intensifs
- Le découpage de la liste `points` est désormais robuste : les virgules
  internes aux parenthèses sont détectées et protégées, ce qui permet la
  syntaxe naturelle sans accolades supplémentaires

### Corrigé
- Bug d'unités TikZ : les coordonnées des tracés sont maintenant
  explicitement en points (`pt`), ce qui évite un débordement vertical et
  horizontal du `tikzpicture` (les nombres purs étaient interprétés en
  centimètres par TikZ, ce qui produisait des repères géants invisibles)
- Bug de découpage des points multiples : `\foreach` traite correctement
  chaque point individuellement (ajout d'une virgule séparatrice entre les
  éléments de la liste)
- Bug d'affichage des couleurs : la couleur d'un point ne s'affiche plus à
  côté de son étiquette
- Bug `(NaN,NaN)` : les coordonnées vides ne sont plus transmises à
  `\pgfmathsetmacro`

## [1.0] - 2026-09-10

### Ajouté
- Première version de `\axegradue` : trace un axe gradué horizontal avec
  TikZ
  - Paramètres nommés : `longueur`, `debut`, `fin`, `pas`, `nombre`, `points`
  - Placement de points avec syntaxe `nom/position` ou
    `nom/position/couleur`
- Première version de `\axegraduepoints` : variante avec les points en
  argument obligatoire