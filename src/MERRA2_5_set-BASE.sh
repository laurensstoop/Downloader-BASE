# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
#
# 

### Make single var files per year

for Y in $(seq 1980 2019);do 
    # Fix the variables for the radiation
    cdo select,name=ssrd -mergetime MERRA2-EU_$Y*.nc MERRA2-EU_ssrd_$Y.nc
    cdo shifttime,-30min MERRA2-EU_ssrd_$Y.nc /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: MERRA2" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_ssrd_$Y.nc
done


for Y in $(seq 1980 2019);do 
    # Fix the variables for the temperature
    cdo select,name=t2m -mergetime MERRA2-EU_$Y*.nc MERRA2-EU_t2m_$Y.nc
    cdo shifttime,-30min -addc,-273.15 MERRA2-EU_t2m_$Y.nc /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: MERRA2" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_t2m_$Y.nc
done


for Y in $(seq 1980 2019);do 
    # Fix the variables for the windspeed
    cdo select,name=wspd -mergetime MERRA2-EU_$Y*.nc MERRA2-EU_wspd_$Y.nc
    cdo shifttime,-30min MERRA2-EU_wspd_$Y.nc /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: MERRA2" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Windspeed at 10 meter masked for European region" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd_$Y.nc
done

for Y in $(seq 1980 2019);do 
    # Fix the variables for the windspeed
    cdo select,name=wspd50m -mergetime MERRA2-EU_$Y*.nc MERRA2-EU_wspd50m_$Y.nc
    cdo shifttime,-30min MERRA2-EU_wspd50m_$Y.nc /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: MERRA2" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    ncatted -O -a long_name,wspd50m,o,c,"Windspeed at 50 meter masked for European region" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
    ncatted -O -a short_name,wspd50m,o,c,"wspd50m" -h /media/stoop/DataDrive/MERRA2/MERRA2-EU_BASE/MERRA2-EU_wspd50m_$Y.nc
done

