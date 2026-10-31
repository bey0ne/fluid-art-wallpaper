# Fluide microscopique

Fond d'écran animé pour [Wallpaper Engine](https://www.wallpaperengine.io/) : un liquide huileux orange, jaune et rose où flottent des taches couvertes d'un motif en labyrinthe, avec des bulles et des reflets brillants. Quand la souris passe dessus, le fluide est poussé et étiré, puis le motif repousse.

Inspiré par l'esthétique des films de « fluid art » microscopique. Tout est généré en temps réel (WebGL2), aucune vidéo n'est utilisée.

![Aperçu](preview.jpg)

![Avec la souris](docs/souris.jpg)

## Installation dans Wallpaper Engine

1. Téléchargez ce dépôt (bouton **Code → Download ZIP**) et décompressez-le.
2. Dans Wallpaper Engine, cliquez sur **Ouvrir le fond d'écran → Ouvrir depuis un fichier** et choisissez `index.html`.
   Ou bien copiez le dossier dans `Wallpaper Engine/projects/myprojects/` puis relancez Wallpaper Engine.
3. Pour que la souris agisse, vérifiez que l'option d'interaction souris est activée dans les réglages de Wallpaper Engine (elle l'est par défaut).

## Réglages

| Réglage | Effet |
| --- | --- |
| Palette | Ambre (proche de la vidéo d'origine), Océan, Néon |
| Vitesse | Vitesse du mouvement ambiant du liquide |
| Force de la souris | 0 désactive l'interaction |
| Quantité de taches | Surface couverte par les taches à motif |
| Taille du motif | Plus la valeur est grande, plus les « vers » du labyrinthe sont gros (et moins c'est coûteux pour la carte graphique) |
| Bulles | Affiche ou masque les bulles d'huile |

## Aperçu dans un navigateur

Ouvrez `index.html` dans Chrome ou Edge. On peut tester les réglages par l'URL, par exemple `index.html?palette=2&speed=1.5&patternScale=2.5&bubbles=0`.

## Fonctionnement

- **Motif labyrinthe** : simulation de réaction-diffusion Gray-Scott (f = 0.0545, k = 0.062), active seulement à l'intérieur des taches.
- **Taches** : un masque transporté par le fluide, qui revient doucement vers une forme de bruit lente.
- **Souris** : la vitesse du curseur est injectée dans un champ de vitesse amorti, qui transporte la matière et déforme le fond.
- **Rendu** : fond en bruit fractal déformé, relief calculé à partir du motif pour les reflets, bulles réfractantes.
