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



#! old

### Run in the Vars folder

for Y in $(seq 1958 2018);do 
    # Fix the variables for the radiation
    cdo chname,dswrf,ssrd -settaxis,$Y-01-01,00:00:00,3hours JRA55-EU_ssrd_$Y.nc /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
done


for Y in $(seq 1958 2018);do 
    # Fix the variables for the temperature
    cdo chname,2t,t2m -addc,-273.15 JRA55-EU_t2m_$Y.nc /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
done


for Y in $(seq 1958 2018);do 
    # Fix the variables for the windspeed
    cdo chname,10u,wspd -sqrt -add -sqr JRA55-EU_u10_$Y.nc -sqr JRA55-EU_u10_$Y.nc /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Windspeed at 10 meter masked for European region" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/stoop/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
done


