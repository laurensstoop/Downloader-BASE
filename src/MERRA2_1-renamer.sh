# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl

for f in MERRA2*.nc4.nc4; 
do 
    mv "$f" $(echo "$f" | sed 's/.nc4.nc4/.nc4/g'); 
done

for f in MERRA2_100*; 
do 
    mv "$f" $(echo "$f" | sed 's/_100./_/g'); 
done

for f in MERRA2_200*; 
do 
    mv "$f" $(echo "$f" | sed 's/_200./_/g'); 
done

for f in MERRA2_300*; 
do 
    mv "$f" $(echo "$f" | sed 's/_300./_/g'); 
done

for f in MERRA2_400*; 
do 
    mv "$f" $(echo "$f" | sed 's/_400./_/g'); 
done
