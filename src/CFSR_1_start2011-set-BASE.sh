# Laurens Stoop l.p.stoop@uu.nl/ laurensstoop.nl
#
# 


# Radiation
### Run in the origin folder
months='01 02 03' # 04 05 06 07 08 09 10 11 12'
for Y in $(seq 2011 2011);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFSv2/origin/dswsfc.gdas.$Y$M.grb2 /media/stoop/DataStager/TEMP/CFSR/dswsfc.gdas.$Y$M.nc
        # Fix the variables for the radiation
        cdo chname,dswrf,ssrd /media/stoop/DataStager/TEMP/CFSR/dswsfc.gdas.$Y$M.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y*.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSR" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc
    ncatted -a history,global,d,, -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_ssrd_$Y.nc /media/stoop/DataFiles/CFSR-EU_BASE/CFSR-EU_ssrd_$Y.nc
done



# temperature
### Run in the origin folder
months='01 02 03' # 04 05 06 07 08 09 10 11 12'
for Y in $(seq 2011 2011);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFSv2/origin/tmp2m.gdas.$Y$M.grb2 /media/stoop/DataStager/TEMP/CFSR/tmp2m.gdas.$Y$M.nc
        # Fix the variables for the radiation
        cdo chname,2t,t2m -addc,-273.15 /media/stoop/DataStager/TEMP/CFSR/tmp2m.gdas.$Y$M.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y*.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSR" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc
    ncatted -a history,global,d,, -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_t2m_$Y.nc /media/stoop/DataFiles/CFSR-EU_BASE/CFSR-EU_t2m_$Y.nc
done



# wind speed
### Run in the origin folder
months='01 02 03' # 04 05 06 07 08 09 10 11 12'
for Y in $(seq 2011 2011);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFSv2/origin/wnd10m.gdas.$Y$M.grb2 /media/stoop/DataStager/TEMP/CFSR/wnd10m.gdas.$Y$M.nc
        # Fix the variables for the radiation
        cdo 'expr,wspd=sqrt(10u^2+10v^2)' /media/stoop/DataStager/TEMP/CFSR/wnd10m.gdas.$Y$M.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y*.nc /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSR" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for European region" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -O -a units,wspd,o,c,"m s**-1" -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc
    ncatted -a history,global,d,, -h /media/stoop/DataStager/TEMP/CFSR/CFSR-EU_wspd_$Y.nc /media/stoop/DataFiles/CFSR-EU_BASE/CFSR-EU_wspd_$Y.nc
done



