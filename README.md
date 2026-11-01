# Goutte de pluie

Fond d'écran animé pour [Wallpaper Engine](https://www.wallpaperengine.io/). Ton écran est couvert de gouttelettes comme une surface mouillée, et **une seule petite goutte suit la souris** en coulant comme une goutte de pluie sur une vitre. Tout est calculé en temps réel en WebGL2 : aucune vidéo n'est utilisée.

![Aperçu](preview.jpg)

## La goutte

- Elle rejoint le curseur avec de l'inertie et une vitesse limitée, en serpentant un peu entre les gouttelettes. Une petite traction ne suffit pas à la décoller : elle reste accrochée tant que la souris bouge à peine.
- Quand elle file, sa queue, retenue par la surface, s'étire en filet derrière une tête ronde. Quand elle ralentit, la tension de surface rétracte la queue et la goutte redevient ronde.
- Son volume est conservé. Elle s'amincit en s'étirant, grossit en avalant les gouttelettes et les perles qu'elle touche, et perd de l'eau en laissant des perles au bout de sa queue.
- Elle essuie la buée et les gouttelettes sur son passage. La traînée propre se recouvre peu à peu : les plus petites gouttelettes reviennent d'abord.

## La surface

- Des milliers de gouttelettes de trois tailles, avec de la buée entre elles qui floute le fond.
- Chaque goutte agit comme une lentille : elle montre une petite image renversée et nette de ce qui l'entoure, avec un bord sombre, un reflet et la lumière concentrée du côté opposé.
- Les gouttes proches se rejoignent par des ponts de liquide, comme de vraies gouttes.
- Le fond est abstrait : des volutes de couleur qui coulent très lentement. Tu peux choisir une palette, ta propre couleur ou ta propre image.

## Installation

### Avec git (mises à jour faciles)

```
git clone -b v2-realiste https://github.com/bey0ne/fluid-art-wallpaper "D:\Wallpaper\fluid-art-wallpaper"
```

Ensuite, reliez le dossier aux projets de Wallpaper Engine, en adaptant le chemin de Steam si besoin. Lancez cette commande dans une invite de commandes :

```
mklink /J "C:\Program Files (x86)\Steam\steamapps\common\wallpaper_engine\projects\myprojects\fluid-art-wallpaper" "D:\Wallpaper\fluid-art-wallpaper"
```

Le fond d'écran apparaît alors dans Wallpaper Engine. Pour récupérer une nouvelle version, double-cliquez sur `mettre-a-jour.bat`, puis réappliquez le fond d'écran.

### Sans git

Téléchargez le ZIP (**Code → Download ZIP**). Dans Wallpaper Engine, ouvrez **Ouvrir le fond d'écran → Ouvrir depuis un fichier** et choisissez `index.html`.

## Réglages

| Réglage | Effet |
| --- | --- |
| Taille de la goutte | Rayon de la goutte qui suit la souris |
| Vitesse de la goutte | Vitesse à laquelle elle rejoint le curseur ; 0 = elle ne bouge plus |
| Perles laissées derrière la goutte | La traînée de petites gouttes au bout de sa queue |
| Densité des gouttelettes | Quantité de gouttelettes sur la surface ; 0 = surface sèche |
| Retour des gouttelettes dans la traînée | Plus la valeur est grande, plus la traînée se recouvre vite |
| Buée | Voile flou entre les gouttelettes |
| Couleurs du fond, Ma couleur | Palette du fond abstrait, ou ta propre couleur |
| Image de fond | Ton image à la place du fond abstrait (facultatif) |
| Qualité | « Auto » baisse la résolution sur les cartes graphiques intégrées (Intel Iris, etc.) ou si les images saccadent |

## Aperçu dans un navigateur

Ouvrez `index.html` dans Chrome ou Edge. Les réglages se testent par l'URL, par exemple `index.html?palette=1&dropsize=1.5&density=1.3`.

## Fonctionnement

- **Goutte** : une tête et une queue de 7 nœuds simulées sur le processeur. La tête suit un ressort amorti vers le curseur, avec une vitesse limitée, un seuil d'accroche et un léger serpentement. Chaque nœud de la queue est tiré par celui de devant (longueur maximale) et rétracté vers lui par la tension de surface. Le rayon découle du volume, que la forme étirée répartit le long de la queue.
- **Eau qui bouge** : la goutte, sa queue et ses perles sont dessinées en bosses lisses additionnées dans une texture flottante. Leur somme est seuillée comme des métaballes, d'où les ponts de liquide entre gouttes voisines ; le relief donne les normales.
- **Gouttelettes posées** : trois couches procédurales, une gouttelette au plus par cellule, ajoutées au même relief. Une carte basse résolution dit où la surface a été essuyée ; chaque gouttelette réapparaît quand la carte dépasse son seuil.
- **Rendu** : réfraction du fond selon la normale (image renversée), bord sombre, reflet spéculaire, lumière concentrée, buée qui floute le fond par mipmaps, vignettage léger.
