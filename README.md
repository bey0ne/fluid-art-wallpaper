# Goutte microscopique

Fond d'écran animé pour [Wallpaper Engine](https://www.wallpaperengine.io/), dans le décor des films microscopiques de liquides de Kamil Czapiga. **Une seule petite goutte suit la souris**, et elle coule comme une goutte de pluie. C'est un liquide à motifs, avec des vers corail, moutarde et olive serrés dans un liquide bleu nuit. Tout est calculé en temps réel en WebGL2 : aucune vidéo n'est utilisée.

![Aperçu](preview.jpg)

## La goutte

- Elle rejoint le curseur avec de l'inertie et une vitesse limitée, par petits à-coups, en serpentant un peu.
- Elle reste accrochée tant que la souris tire à peine. Pendant ce temps, elle s'étire vers le curseur, puis elle part d'un coup.
- En route, elle prend une forme de larme : la tête est ronde et l'arrière s'effile en queue. Le motif suit le liquide et s'allonge vers l'arrière.
- Quand elle freine, le liquide déborde vers l'avant, puis la goutte tremble et se pose. Le bout de sa queue se vide dans la goutte.
- Ses vers sont bombés et mouillés : chacun accroche un reflet de la fenêtre du studio. La goutte est une calotte basse posée sur le support, avec une ombre courte et un contact sombre, pas une bille.

## La traînée

- La goutte laisse un filet du même liquide. Ses vers y sont étirés en traits, et sa largeur ondule un peu.
- Après un instant, le filet se resserre entre des points irréguliers. Il se coupe en tronçons arrondis, qui deviennent des perles d'abord allongées, puis rondes.
- Chaque perle a la couleur du trait dont elle est née. Les perles ont toutes les tailles : beaucoup de petites, quelques grosses.
- Les perles sèchent lentement. La goutte avale celles qu'elle retouche.

## Les décors

Quatre décors, tirés des images de la vidéo :

- **Pêche** : un liquide jaune pêche avec une nappe brune.
- **Bordeaux** : des encres orange et bordeaux.
- **Rose** : un liquide rose, avec une nappe orange et des fils blancs.
- **Ambre** : une huile ambrée, avec de grosses gouttes d'huile floues.

Les nappes sont épaisses. Leur bord est bombé et accroche la lumière, et la fenêtre du studio se reflète sur le liquide du fond.

## Installation

### Avec git (mises à jour faciles)

```
git clone -b v2-realiste https://github.com/bey0ne/fluid-art-wallpaper "D:\Wallpaper\fluid-art-wallpaper"
```

Ensuite, reliez le dossier aux projets de Wallpaper Engine. Lancez cette commande dans une invite de commandes, en adaptant le chemin de Steam si besoin :

```
mklink /J "C:\Program Files (x86)\Steam\steamapps\common\wallpaper_engine\projects\myprojects\fluid-art-wallpaper" "D:\Wallpaper\fluid-art-wallpaper"
```

Le fond d'écran apparaît alors dans Wallpaper Engine. Pour récupérer une nouvelle version, double-cliquez sur `mettre-a-jour.bat`, puis réappliquez le fond d'écran.

### Sans git

Téléchargez le ZIP (**Code → Download ZIP**). Dans Wallpaper Engine, ouvrez **Ouvrir le fond d'écran → Ouvrir depuis un fichier** et choisissez `index.html`.

## Réglages

| Réglage | Effet |
| --- | --- |
| Taille de la goutte | Rayon de la goutte |
| Vitesse de la goutte | Vitesse à laquelle elle rejoint le curseur ; 0 = elle ne bouge plus |
| Liquide laissé derrière la goutte | Largeur du filet et nombre de perles ; 0 = aucune traînée |
| Secondes avant que les perles sèchent | Durée de vie des perles |
| Décor | Pêche, Bordeaux, Rose ou Ambre |
| Qualité | « Auto » baisse la résolution sur les cartes graphiques intégrées (Intel Iris, etc.) ou si les images saccadent |

## Aperçu dans un navigateur

Ouvrez `index.html` dans Chrome ou Edge. Les réglages se testent par l'URL, par exemple `index.html?decor=3&dropsize=1.5&trail=1.4`.

## Fonctionnement

- **Motif** : une réaction-diffusion de Gray-Scott, calculée à l'avance, donne les vers. Chacun reçoit une couleur, et la texture garde aussi la distance au bord de chaque ver, qui sert à dessiner le contour noir, le sillon bleu et le relief.
- **Mouvement** : la goutte suit un ressort amorti vers le curseur, avec une vitesse limitée, un seuil d'accroche et un léger serpentement. Sa forme est un deuxième ressort, peu amorti : il s'étire selon la traction, la vitesse et l'inertie du liquide, d'où le tremblement à l'arrêt.
- **Liquide** : la tête, la queue, le filet et les perles sont dessinés en bosses lisses, additionnées dans une texture flottante. Leur somme est seuillée comme des métaballes, si bien que tout se fond en un seul liquide. Le filet se rompt en morceaux qui disparaissent de plus en plus tard près des points de rupture : les tronçons raccourcissent par les bouts, qui restent ronds.
- **Rendu** : la hauteur est une calotte basse, avec un angle de contact d'environ 40°. Le relief des vers s'y ajoute. Le rendu combine les reflets du studio et du décor (Fresnel), la fenêtre nette sur chaque ver, un liseré au contact, une ombre courte et un contact sombre. Le décor est calculé une fois, avec des nappes au bord bombé, des bulles en lentilles et un reflet de la fenêtre sur le liquide du fond.
