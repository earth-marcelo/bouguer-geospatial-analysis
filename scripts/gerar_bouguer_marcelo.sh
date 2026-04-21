#!/usr/bin/env bash
#
#
#COR=turbo
LIMITES=-60.0/-10.0/-45.0/-15.0
CAMINHO=/home/marcelo/erg_project/outputs/grids 

gmt gravfft $CAMINHO/topo.grd -D1865 -G$CAMINHO/water.nc -E4 -W0 -Fb -f0x,1y -V
gmt grdmath $CAMINHO/freeair.grd $CAMINHO/water.nc ADD = $CAMINHO/bouguer.grd -V

gmt grdlandmask -R$LIMITES -Df -I1m -N1/NaN/NaN/NaN/NaN -G$CAMINHO/land_mask_tmp.grd -V

gmt grdsample $CAMINHO/land_mask_tmp.grd \
  -R$CAMINHO/topo.grd \
  -G$CAMINHO/land_mask.grd

gmt grdmath $CAMINHO/land_mask.grd $CAMINHO/bouguer.grd MUL = $CAMINHO/bouguer_290.grd

rm $CAMINHO/land_mask.grd $CAMINHO/land_mask_tmp.grd $CAMINHO/water.nc $CAMINHO/bouguer.grd 

gmt grdinfo $CAMINHO/topo.grd
gmt grdinfo $CAMINHO/freeair.grd
gmt grdinfo $CAMINHO/bouguer_267.grd
gmt grdinfo $CAMINHO/bouguer_290.grd

#rm $CAMINHO/land_mask.grd $CAMINHO/land_mask_tmp.grd $CAMINHO/water.nc $CAMINHO/bouguer.grd 

#gmt grdmath $CAMINHO/topo.grd -200 LT $CAMINHO/bouguer.grd NaN IFELSE = $CAMINHO/bouguer_267.grd -V

#gmt grdmath $CAMINHO/topo.grd -200 GE NaN $CAMINHO/bouguer_267.grd IFELSE = $CAMINHO/bouguer_mask.grd

#gmt grdmath $CAMINHO/topo.grd -200 LT $CAMINHO/bouguer_267.grd NaN IFELSE = $CAMINHO/bouguer_mask.grd

#gmt grdmath $CAMINHO/topo.grd -200 GE 1 NaN IFELSE = $CAMINHO/raso.grd

#gmt grdmath $CAMINHO/topo.grd -200 LT NAN = $CAMINHO/mascara.grd -V

#gmt grdmath $CAMINHO/bouguer.grd $CAMINHO/mascara.grd MUL = $CAMINHO/bouguer_267.grd

#gmt grdsample $CAMINHO/land_mask_tmp.grd \
 # -R$CAMINHO/topo.grd \
 # -G$CAMINHO/land_mask.grd

#gmt grdmath $CAMINHO/land_mask.grd $CAMINHO/bouguer.grd MUL = $CAMINHO/bouguer_267.grd

#gmt grdinfo $CAMINHO/bouguer_267.grd

#rm $CAMINHO/land_mask.grd $CAMINHO/land_mask_tmp.grd $CAMINHO/water.nc $CAMINHO/bouguer.grd 


#gmt set MAP_FRAME_TYPE fancy

#gmt begin BOUGUER_$COR pdf

	#gmt grd2cpt $CAMINHO/bouguer_mask.grd -C$COR -L-280/125 -Z -H  > mydata.cpt
	
    #gmt grdimage $CAMINHO/bouguer_mask.grd -JM16c  -Cmydata.cpt -Ei600  -f0x,1y -V

    #gmt makecpt -Cwhite -T0/1/1 > white.cpt
    #gmt grdimage $CAMINHO/raso.grd -Cwhite.cpt -Q
    
    #gmt coast -R$LIMITES -JM16c -Di -B -W1/thin  --FORMAT_GEO_MAP=ddd -V
   # gmt colorbar -DjBR+o-1c/2.5c+w7.0c/0.32c+mc -Bx100f25 -By+lmGal -I -Cmydata.cpt

#gmt end show

#rm  mydata.cpt 

	
