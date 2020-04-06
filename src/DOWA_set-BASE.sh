# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
#
# Not very clean, but it works. 


#####
# DOWA-NL
#####

### Run in the origin folder the following commandline
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2018) ;do
    for M in $month ;do
        cdo select,name=ta -mergetime ./$Y/$M/*/DOWA_40h12tg2_fERA5_NETHERLANDS.NL_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-NL/combine/DOWA-NL_t2m_$Y$M.nc
        cdo select,name=wdir -mergetime ./$Y/$M/*/DOWA_40h12tg2_fERA5_NETHERLANDS.NL_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-NL/combine/DOWA-NL_wdir_$Y$M.nc
        cdo select,name=wspeed -mergetime ./$Y/$M/*/DOWA_40h12tg2_fERA5_NETHERLANDS.NL_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-NL/combine/DOWA-NL_wspd_$Y$M.nc
        cdo select,name=p -mergetime ./$Y/$M/*/DOWA_40h12tg2_fERA5_NETHERLANDS.NL_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-NL/combine/DOWA-NL_mpsl_$Y$M.nc
        cdo select,name=hur -mergetime ./$Y/$M/*/DOWA_40h12tg2_fERA5_NETHERLANDS.NL_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-NL/combine/DOWA-NL_hur_$Y$M.nc
    done
done

#####
# DOWA-EU
#####

### Run in the origin folder the following commandline
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2017) ;do
    for M in $month ;do
        cdo mergetime ./$Y/$M/*/psl_DOWA_40h12tg2_fERA5_NETHERLANDS_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-EU/combine/DOWA-EU_psl_$Y$M.nc
        cdo mergetime ./$Y/$M/*/rsds_DOWA_40h12tg2_fERA5_NETHERLANDS_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-EU/combine/DOWA-EU_rsds_$Y$M.nc
        cdo mergetime ./$Y/$M/*/tas_DOWA_40h12tg2_fERA5_NETHERLANDS_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-EU/combine/DOWA-EU_t2m_$Y$M.nc
        cdo mergetime ./$Y/$M/*/uas_DOWA_40h12tg2_fERA5_NETHERLANDS_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-EU/combine/DOWA-EU_u10_$Y$M.nc
        cdo mergetime ./$Y/$M/*/vas_DOWA_40h12tg2_fERA5_NETHERLANDS_$Y$M*_v1.0.nc /media/stoop/DataDrive/DOWA/DOWA-EU/combine/DOWA-EU_v10_$Y$M.nc
    done
done





### Run in the combine folder
#####
# DOWA-NL
# Temperature
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2018);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,ta,t2m -addc,-273.15 -sellevel,10 ./combine/DOWA-NL_t2m_$Y$M.nc ./preBASE/t2m_$Y$M.nc
    done
    # Combine the months
    cdo mergetime ./preBASE/t2m_$Y*.nc ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    # Remove temp files
    rm ./preBASE/t2m_$Y*.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Netherlands" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: DOWA" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 10 meter masked for Dutch region" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h ./DOWA-NL_BASE/DOWA-NL_t2m_$Y.nc
done

#####
# DOWA-NL
# Wind Speed
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2018);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,wspeed,wspd -sellevel,10 ./combine/DOWA-NL_wspd_$Y$M.nc ./preBASE/wspd_$Y$M.nc
        cdo chname,wspeed,wspd100m -sellevel,100 ./combine/DOWA-NL_wspd_$Y$M.nc ./preBASE/wspd100m_$Y$M.nc
    done
    # Combine the months
    cdo mergetime ./preBASE/wspd_$Y*.nc ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    cdo mergetime ./preBASE/wspd100m_$Y*.nc ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    # Remove temp files
    rm ./preBASE/wspd_$Y*.nc
    rm ./preBASE/wspd100m_$Y*.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Netherlands" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a map_area,global,o,c,"Netherlands" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: DOWA" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: DOWA" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for Dutch region" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a long_name,wspd100m,o,c,"Wind speed at 100  meter masked for Dutch region" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h ./DOWA-NL_BASE/DOWA-NL_wspd_$Y.nc
    ncatted -O -a short_name,wspd100m,o,c,"wspd100m" -h ./DOWA-NL_BASE/DOWA-NL_wspd100m_$Y.nc
done

#####
# DOWA-NL
# Wind direction
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2018);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,wdir,wdir -sellevel,10 ./combine/DOWA-NL_wdir_$Y$M.nc ./preBASE/wdir_$Y$M.nc
        cdo chname,wdir,wdir100m -sellevel,100 ./combine/DOWA-NL_wdir_$Y$M.nc ./preBASE/wdir100m_$Y$M.nc
    done
    # Combine the months
    cdo mergetime ./preBASE/wdir_$Y*.nc ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    cdo mergetime ./preBASE/wdir100m_$Y*.nc ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    # Remove temp files
    rm ./preBASE/wdir_$Y*.nc
    rm ./preBASE/wdir100m_$Y*.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Netherlands" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a map_area,global,o,c,"Netherlands" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: DOWA" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: DOWA" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    ncatted -O -a long_name,wdir,o,c,"Wind direction at 10 meter masked for Dutch region" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a long_name,wdir100m,o,c,"Wind direction at 100 meter masked for Dutch region" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
    ncatted -O -a short_name,wdir,o,c,"wdir" -h ./DOWA-NL_BASE/DOWA-NL_wdir_$Y.nc
    ncatted -O -a short_name,wdir100m,o,c,"wdir100m" -h ./DOWA-NL_BASE/DOWA-NL_wdir100m_$Y.nc
done



####
# DOWA-EU
####

#####
# DOWA-EU
# Temperature
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2017);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,tas,t2m -addc,-273.15  ./combine/DOWA-EU_t2m_$Y$M.nc ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        # Rename the attributes and set the variables attributes for windspeed
        ncatted -O -a map_area,global,o,c,"North-West_Europe" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a experiment,global,o,c,"Model: DOWA-extra" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for North West European region" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a short_name,t2m,o,c,"t2m" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
        ncatted -O -a units,t2m,o,c,"degC" -h ./DOWA-EU_BASE/DOWA-EU_t2m_$Y$M.nc
    done
done

#####
# DOWA-EU
# ssrd
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2017);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,rsds,ssrd -shifttime,-30min  -divc,3600.  ./combine/DOWA-EU_rsds_$Y$M.nc ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        # Rename the attributes and set the variables attributes for windspeed
        ncatted -O -a map_area,global,o,c,"North-West_Europe" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a experiment,global,o,c,"Model: DOWA-extra" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for North West European region" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a short_name,ssrd,o,c,"ssrd" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
        ncatted -O -a units,ssrd,o,c,"W/m^2" -h ./DOWA-EU_BASE/DOWA-EU_ssrd_$Y$M.nc
    done
done


#####
# DOWA-EU
# wspd
month='01 02 03 04 05 06 07 08 09 10 11 12' 
for Y in $(seq 2008 2017);do 
    for M in $month ;do
        # Fix the variables for the temperature
        cdo chname,uas,wspd -sqrt -add -sqr ./combine/DOWA-EU_u10_$Y$M.nc -add -sqr ./combine/DOWA-EU_v10_$Y$M.nc  ./combine/DOWA-EU_u10_$Y$M.nc ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        # Rename the attributes and set the variables attributes for windspeed
        ncatted -O -a map_area,global,o,c,"North-West_Europe" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        ncatted -O -a experiment,global,o,c,"Model: DOWA-extra" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        ncatted -O -a long_name,wspd,o,c,"Wind speed masked for North West European region" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
        ncatted -O -a short_name,wspd,o,c,"wspd" -h ./DOWA-EU_BASE/DOWA-EU_wspd_$Y$M.nc
    done
done




