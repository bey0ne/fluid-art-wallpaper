# Fluide microscopique

Fond d'écran animé pour [Wallpaper Engine](https://www.wallpaperengine.io/), recréé à partir d'un film de « fluid art » microscopique. Une grosse goutte de liquide couverte de vers de peinture (corail, moutarde, olive) cernés de noir, séparés par des sillons bleus brillants, **suit la souris** dans le décor. C'est une vraie simulation de fluide, calculée en temps réel en WebGL2 : aucune vidéo n'est utilisée.

![Aperçu](preview.jpg)

## La goutte suit la souris

- Quand la souris bouge, la goutte la suit avec de l'inertie. Elle est tirée par l'avant : son arrière, moins retenu, traîne et s'étire, et le motif s'étire avec lui.
- Quand elle ralentit, la tension de surface la ramène vers une forme ronde.
- Elle pousse le liquide autour d'elle et entraîne avec elle la couche de liquide qui la touche, ce qui fait tourbillonner les encres du décor.
- Quand la souris ne bouge plus, la goutte dérive lentement toute seule.

## Les 4 états

Le fond d'écran passe de l'un à l'autre en continu, comme dans la vidéo. À chaque transition, l'encre du nouvel état envahit l'écran et le motif de la goutte se transforme.

1. **Goutte corail** : fond jaune paille, vers corail, moutarde et olive cernés de noir, sillons bleu nuit avec des filets clairs.
2. **Goutte rose et encre chocolat** : une goutte rose mate, cerclée d'un reflet blanc en « U », s'enfonce dans la grosse goutte et écrase le motif autour d'elle. Des filets d'encre chocolat s'enroulent autour, de grosses bulles transparentes flottent, l'ombre devient bleu-violet.
3. **Liquide rose, lignes lumineuses et encre rouge** : le liquide devient rose, traversé de lignes lumineuses blanc-cyan qui serpentent avec le courant, de particules sombres et de nuages d'encre rouge-orangée. La goutte se déchire et ses vers se cassent en cellules serrées au liseré bleu.
4. **Huile ambrée** : liquide doré et grosses gouttes d'huile floues à bord orangé. La goutte devient une coque d'huile brun olive brillante, pleine de perles orange et jaunes cernées de brun, avec des traînées vertes.

Quand le cycle revient à la goutte corail, les perles s'allongent et redeviennent des vers.

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
| État | Cycle automatique, ou un des 4 états fixe |
| Durée de chaque état | En secondes (15 par défaut) |
| Suivi de la souris | Vitesse à laquelle la goutte rejoint le curseur ; 0 = elle dérive seule |
| Traînée d'encre derrière la goutte | Dépose de l'encre dans le liquide quand elle bouge |
| Taille de la goutte | Rayon de la grosse goutte |
| Taille des vers | Plus la valeur est grande, plus les vers sont gros (et plus c'est léger pour la carte graphique) |
| Vitesse | Vitesse du liquide, de la dérive et des transitions |
| Gouttes d'huile, Flou de mouvement, Mouvement de caméra, Flou de profondeur, Halo lumineux | Effets de rendu |
| Qualité | « Auto » détecte les cartes graphiques intégrées (Intel Iris, etc.) et baisse la résolution si les images saccadent |

## Aperçu dans un navigateur

Ouvrez `index.html` dans Chrome ou Edge. Les réglages se testent par l'URL, par exemple `index.html?phase=1&speed=1.5&quality=0`.

## Fonctionnement

- **Fluide** : simulation Navier-Stokes sur GPU (advection, confinement de vorticité, projection de pression). Des émetteurs invisibles y déposent les encres, transportées sans flou (MacCormack) pour garder des bords nets.
- **La goutte est un liquide** : elle vit dans son propre repère (1,5 hauteur d'écran) qui suit le curseur. Son liquide est entraîné vers la vitesse du repère, fort à l'avant, faible à l'arrière, si bien que l'arrière traîne et s'étire. Son contour (champ de phase d'Allen-Cahn) est transporté par le courant relatif. La tension de surface agit à toutes les échelles : les petites bosses rentrent et les filaments se rétractent (masque très flouté), la forme revient vers l'ellipse de mêmes moments, et un écoulement d'étirement inverse ramène cette ellipse vers le cercle. La surface est conservée. La surface, le centre et les moments d'inertie de la goutte sont calculés sur le GPU par mipmaps, sans relecture.
- **Vers** : réaction-diffusion Gray-Scott en 32 bits, calculée dans le repère de la goutte. Les réglages changent avec l'état : vers, puis cellules serrées, puis perles. Comme les perles restent des perles avec les réglages des vers, le retour à la goutte corail passe par une courte phase de repousse. Près du bord, les vers deviennent des perles puis disparaissent, ce qui laisse un bord sombre.
- **Une couleur par ver** : chaque ver reçoit une identité au hasard qui se propage le long de son cœur (la plus grande l'emporte), puis ses bords prennent l'identité du point le plus haut voisin. La couleur est tirée de cette identité. À chaque état, un front de recoloriage passe en taches sur la goutte et donne une nouvelle couleur à chaque cellule.
- **Goutte rose** : elle repousse le motif autour d'elle par un déplacement qui conserve la surface, d'où les vers écrasés contre elle.
- **Liquide** : les lignes lumineuses, les particules et les reflets de l'huile sont dessinés dans des coordonnées entraînées par le courant (deux jeux décalés, remis à zéro tour à tour), donc ils suivent le liquide et s'étirent avec lui.
- **Rendu** : contours lissés en bicubique, vers bombés au liseré clair, contour noir, sillons bleu nuit avec un ménisque qui reflète le ciel en filets clairs, reflets d'un éclairage de studio (Fresnel), effet dôme au bord, grande ombre portée bleu-violet, nappes de liquides en relief, flou de mouvement, flou de profondeur, bloom.
