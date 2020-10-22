# Laurens Stoop l.p.stoop@uu.nl/ laurensstoop.nl
#
# 


# Radiation
### Run in the origin folder
months='04 05 06 07 08 09 10 11 12' # 01 02 03 
for Y in $(seq 2011 2011);do # 2011 2019);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/DataFiles/CFSv2/origin/dswsfc.cdas1.$Y$M.grb2 /media/DataStager1/TEMP/CFSv2/dswsfc.cdas1.$Y$M.nc
        # Fix the variables for the radiation
        cdo chname,dswrf,ssrd /media/DataStager1/TEMP/CFSv2/dswsfc.cdas1.$Y$M.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y*.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSv2" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
    ncatted -a history,global,d,, -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc /media/DataFiles/CFSv2-EU_BASE/CFSv2-EU_ssrd_$Y.nc
    # Clean up 
    rm /media/DataFiles/CFSv2/origin/dswsfc.cdas1.$Y*.grb2
    rm /media/DataStager1/TEMP/CFSv2/dswsfc.cdas1.$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_ssrd_$Y.nc
done



# temperature
### Run in the origin folder
months='04 05 06 07 08 09 10 11 12' # 01 02 03 
for Y in $(seq 2011 2011);do # 2011 2019);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/DataFiles/CFSv2/origin/tmp2m.cdas1.$Y$M.grb2 /media/DataStager1/TEMP/CFSv2/tmp2m.cdas1.$Y$M.nc
        # Fix the variables for the radiation
        cdo chname,2t,t2m -addc,-273.15 /media/DataStager1/TEMP/CFSv2/tmp2m.cdas1.$Y$M.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y*.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSv2" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
    ncatted -a history,global,d,, -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc /media/DataFiles/CFSv2-EU_BASE/CFSv2-EU_t2m_$Y.nc
    # Clean up 
    rm /media/DataFiles/CFSv2/origin/tmp2m.cdas1.$Y*.grb2
    rm /media/DataStager1/TEMP/CFSv2/tmp2m.cdas1.$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_t2m_$Y.nc
done



# wind speed
### Run in the origin folder
months='04 05 06 07 08 09 10 11 12' # 01 02 03 
for Y in $(seq 2011 2011);do # 2011 2019);do  #1979 2010 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 /media/DataFiles/CFSv2/origin/wnd10m.cdas1.$Y$M.grb2 /media/DataStager1/TEMP/CFSv2/wnd10m.cdas1.$Y$M.nc
        # Fix the variables for the radiation
        cdo 'expr,wspd=sqrt(10u^2+10v^2)' /media/DataStager1/TEMP/CFSv2/wnd10m.cdas1.$Y$M.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y$M.nc
    done
    # Merge the time 
    cdo mergetime /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y*.nc /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFSv2" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for European region" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -O -a units,wspd,o,c,"m s**-1" -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
    ncatted -a history,global,d,, -h /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc /media/DataFiles/CFSv2-EU_BASE/CFSv2-EU_wspd_$Y.nc
    # Clean up 
    rm /media/DataFiles/CFSv2/origin/wnd10m.cdas1.$Y*.grb2
    rm /media/DataStager1/TEMP/CFSv2/wnd10m.cdas1.$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y*.nc
    rm /media/DataStager1/TEMP/CFSv2/CFSv2-EU_wspd_$Y.nc
done



