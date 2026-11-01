# Coalescence

Fond d'écran animé pour [Wallpaper Engine](https://www.wallpaperengine.io/). **Une seule petite goutte suit la souris**, et elle coule comme une goutte de pluie. Quand elle en touche une autre, elles fusionnent. Le thème de départ reprend le décor des films microscopiques de liquides de Kamil Czapiga : un liquide à motifs, avec des vers corail, moutarde et olive serrés dans un liquide bleu nuit. Trois autres thèmes sont au choix : une goutte de pluie sur une vitre la nuit, du mercure, du miel. Tout est calculé en temps réel en WebGL2 : aucune vidéo n'est utilisée.

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

## Quand deux gouttes se touchent

La fusion suit ce qui se passe vraiment entre deux gouttes posées :

- Elles ne s'attirent pas à distance. Rien ne se passe tant que leurs bords ne se touchent pas. Le bord pris en compte est celui de la forme du moment : une goutte étirée vers la souris touche plus loin de ce côté.
- Au contact, un pont de liquide s'ouvre et s'élargit très vite, puis de moins en moins vite.
- La plus petite se vide dans la plus grande, car la pression est plus forte dans une petite goutte. En se vidant, elle reste collée au pont et se fait tirer vers la grande.
- Une toute petite goutte disparaît en quelques centièmes de seconde. Une goutte presque aussi grosse met un quart de seconde. Le miel, épais, met beaucoup plus longtemps.
- La grande se bombe du côté où le liquide arrive, et son centre se déplace vers lui. Ensuite, elle tremble et se pose.
- Dans le thème de la vidéo, la couleur de la goutte avalée entre par le pont. Elle forme une tache qui gagne le milieu en se mélangeant, puis s'efface.

## Les thèmes

| Thème | Ce qu'on voit | Couleurs au choix |
| --- | --- | --- |
| **Microscopique** | Le liquide à motifs de la vidéo, sur l'un de ses quatre décors | D'origine, Lagon, Néon, Ma couleur |
| **Goutte de pluie** | Une goutte d'eau sur une vitre, la nuit. Des lumières floues sont derrière, et la vitre est couverte de gouttelettes. Chaque goutte est une lentille : on y voit les lumières nettes, réduites et à l'envers, avec un liseré sombre au bord. La goutte avale les gouttelettes qu'elle rencontre, et il en retombe de nouvelles. | Ville la nuit, Coucher de soleil, Forêt, Néon, Ma couleur |
| **Mercure** | Un métal liquide sur une ardoise. C'est un miroir bombé, qui ne mouille pas : il ne laisse pas de filet. Quand il file vite, il sème de petites billes, qu'il peut ravaler. | Argent, Or, Cuivre, Ma couleur |
| **Miel** | Du miel sur un marbre clair. Il est épais et lent, ne tremble presque pas, et laisse un long filet qui se casse tard. Plus il est épais, plus il est foncé, et son ombre est dorée. | Acacia, Ambré, Châtaignier, Ma couleur |

« Ma couleur » utilise la couleur choisie dans le réglage du même nom.

## Les décors

Pour le thème Microscopique, quatre décors sont tirés des images de la vidéo :

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
| Thème | Microscopique, Goutte de pluie, Mercure ou Miel |
| Décor | Microscopique : Pêche, Bordeaux, Rose ou Ambre |
| Couleurs de la goutte, Lumières derrière la vitre, Métal, Miel | Les couleurs du thème choisi (seul le réglage du thème en cours s'affiche) |
| Ma couleur | La couleur des palettes « Ma couleur » |
| Taille de la goutte | Rayon de la goutte |
| Vitesse de la goutte | Vitesse à laquelle elle rejoint le curseur ; 0 = elle ne bouge plus |
| Liquide laissé derrière la goutte | Largeur du filet et nombre de perles ; 0 = aucune traînée |
| Secondes avant que les perles sèchent | Durée de vie des perles (le mercure ne sèche pas) |
| Qualité | « Auto » baisse la résolution sur les cartes graphiques intégrées (Intel Iris, etc.) ou si les images saccadent |

## Aperçu dans un navigateur

Ouvrez `index.html` dans Chrome ou Edge. Les réglages se testent par l'URL, par exemple `index.html?decor=3&dropsize=1.5&trail=1.4`, `index.html?theme=1&raincolors=1` ou `index.html?theme=2&metal=3&mycolor=40c0ff`.

## Fonctionnement

- **Motif** : une réaction-diffusion de Gray-Scott, calculée à l'avance, donne les vers. Chacun reçoit une couleur, et la texture garde aussi la distance au bord de chaque ver, qui sert à dessiner le contour noir, le sillon bleu et le relief.
- **Mouvement** : la goutte suit un ressort amorti vers le curseur, avec une vitesse limitée, un seuil d'accroche et un léger serpentement. Sa forme est un deuxième ressort, peu amorti : il s'étire selon la traction, la vitesse et l'inertie du liquide, d'où le tremblement à l'arrêt.
- **Liquide** : la tête, la queue, le filet et les perles sont dessinés en bosses lisses, additionnées dans une texture flottante. Leur somme est seuillée comme des métaballes, si bien que tout se fond en un seul liquide. Le filet se rompt en morceaux qui disparaissent de plus en plus tard près des points de rupture : les tronçons raccourcissent par les bouts, qui restent ronds.
- **Fusion** : chaque perle ou gouttelette touchée transfère son volume à la goutte selon une courbe douce. Le pont est une chaîne de bosses entre les deux, dont la largeur croît comme t^(2/3), puis diminue à mesure que la petite se vide. Le centre de la goutte se déplace selon le centre de masse, et le ressort de sa forme reçoit l'élan du liquide qui entre.
- **Matières** : l'eau, le mercure et le miel ont une calotte sphérique, avec un angle de contact de 50°, 88° ou 42°. Dans l'eau, chaque rayon est dévié selon la loi de Snell à la sortie de la face bombée. Au-delà d'environ 48° de pente, il y a réflexion totale, d'où le liseré sombre. Le mercure reflète un studio (plafond, murs, horizon, support). Le miel absorbe la lumière selon son épaisseur (loi de Beer-Lambert), et le dôme concentre la lumière du côté opposé à la fenêtre.
- **Rendu** (thème de la vidéo) : la hauteur est une calotte basse, avec un angle de contact d'environ 40°. Le relief des vers s'y ajoute. Le rendu combine les reflets du studio et du décor (Fresnel), la fenêtre nette sur chaque ver, un liseré au contact, une ombre courte et un contact sombre. Le décor est calculé une fois, avec des nappes au bord bombé, des bulles en lentilles et un reflet de la fenêtre sur le liquide du fond.
