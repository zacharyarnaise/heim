magick l8kmop.png -strip -thumbnail 1000x1000^ -gravity center -extent 1000x1000 l8kmop_square.png

magick l8kmop_square.png -size 1000x1000 xc:white -fill "rgba(0,0,0,0.7)" -draw "polygon 840,1000 1000,1000 1000,0 960,0" -fill black -draw "polygon 1000,1000 1000,0 960,1000" -alpha Off -compose CopyOpacity -composite l8kmop_quad.png
