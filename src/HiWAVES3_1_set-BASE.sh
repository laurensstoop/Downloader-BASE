# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
#
# Not very clean, but it works. 
#
# Got the data for europe allready cut


M='HadGEM'
C='PD'
drive='/media/DataGate3'
source_dir="HiWAVES3/Europe/HiWAVES3_${M}2-ES_${C}"
temp_dir='/home/TEMP3/HiWAVES3'
starts='01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16' 
runs='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24' 

### Run in the origin folder the following commandline
for S in $starts ;do
    for R in $runs ;do

        # Merge the five year runs back into 1 file
        cdo mergetime $drive/$source_dir/psl_d_${M}2-ES_${C}_s${S}r${R}_*_europe.nc $temp_dir/merge/temp_mpsl.nc
        cdo mergetime $drive/$source_dir/tas_d_${M}2-ES_${C}_s${S}r${R}_*_europe.nc $temp_dir/merge/temp_tas.nc
        cdo mergetime $drive/$source_dir/tasmax_d_${M}2-ES_${C}_s${S}r${R}_*_europe.nc $temp_dir/merge/temp_tasmax.nc
        cdo mergetime $drive/$source_dir/rsds_d_${M}2-ES_${C}_s${S}r${R}_*_europe.nc $temp_dir/merge/temp_rsds.nc
        cdo mergetime $drive/$source_dir/sfcwind_d_${M}2-ES_${C}_s${S}r${R}_*_europe.nc $temp_dir/merge/temp_sfcwind.nc

        # MPSL Base set             
        cdo chname,psl,mpsl -divc,100 $temp_dir/merge/temp_mpsl.nc $temp_dir/base/temp_mpsl.nc
        # Rename the attributes and set the variables attributes for mean sea level pressure
        ncatted -O -a experiment,global,o,c,"Model: $M" -h $temp_dir/base/temp_mpsl.nc
        ncatted -O -a climate,global,o,c,"$C" -h $temp_dir/base/temp_mpsl.nc
        ncatted -O -a project,global,o,c,"HiWAVES3" -h $temp_dir/base/temp_mpsl.nc
        ncatted -O -a email,global,a,c,"l.p.stoop@uu.nl" -h $temp_dir/base/temp_mpsl.nc
        ncatted -O -a long_name,mpsl,o,c,"Mean sea level pressure masked for European region" -h $temp_dir/base/temp_mpsl.nc
        ncatted -O -a short_name,mpsl,o,c,"mpsl" -h $temp_dir/base/temp_mpsl.nc
        ncatted -a units,mpsl,o,c,"hPa" -h $temp_dir/base/temp_mpsl.nc $drive/HiWAVES3-${M}-${C}-EU_BASE/HiWAVES3-${M}-${C}-EU_mpsl_s${S}r$R.nc

        # T2m Base set             
        cdo chname,tas,t2m -addc,-273.15 $temp_dir/merge/temp_tas.nc $temp_dir/base/temp_t2m.nc
        # Rename the attributes and set the variables attributes for temperature
        ncatted -O -a experiment,global,o,c,"Model: $M" -h $temp_dir/base/temp_t2m.nc
        ncatted -O -a climate,global,o,c,"$C" -h $temp_dir/base/temp_t2m.nc
        ncatted -O -a project,global,o,c,"HiWAVES3" -h $temp_dir/base/temp_t2m.nc
        ncatted -O -a email,global,a,c,"l.p.stoop@uu.nl" -h $temp_dir/base/temp_t2m.nc
        ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h $temp_dir/base/temp_t2m.nc
        ncatted -O -a short_name,t2m,o,c,"t2m" -h $temp_dir/base/temp_t2m.nc
        ncatted -a units,t2m,o,c,"degC" -h $temp_dir/base/temp_t2m.nc $drive/HiWAVES3-${M}-${C}-EU_BASE/HiWAVES3-${M}-${C}-EU_t2m_s${S}r$R.nc

        # T2max Base set             
        cdo chname,tasmax,t2max -addc,-273.15 $temp_dir/merge/temp_tasmax.nc $temp_dir/base/temp_t2max.nc
        # Rename the attributes and set the variables attributes for daily maximum temperature
        ncatted -O -a experiment,global,o,c,"Model: $M" -h $temp_dir/base/temp_t2max.nc
        ncatted -O -a climate,global,o,c,"$C" -h $temp_dir/base/temp_t2max.nc
        ncatted -O -a project,global,o,c,"HiWAVES3" -h $temp_dir/base/temp_t2max.nc
        ncatted -O -a email,global,a,c,"l.p.stoop@uu.nl" -h $temp_dir/base/temp_t2max.nc
        ncatted -O -a long_name,t2max,o,c,"Daily maximum temperature at 2 meter masked for European region" -h $temp_dir/base/temp_t2max.nc
        ncatted -O -a short_name,t2max,o,c,"t2max" -h $temp_dir/base/temp_t2max.nc
        ncatted -a units,t2max,o,c,"degC" -h $temp_dir/base/temp_t2max.nc $drive/HiWAVES3-${M}-${C}-EU_BASE/HiWAVES3-${M}-${C}-EU_t2max_s${S}r$R.nc

        # Wspd Base set             
        cdo chname,sfcwind,wspd $temp_dir/merge/temp_sfcwind.nc $temp_dir/base/temp_wspd.nc
        # Rename the attributes and set the variables attributes for windspeed
        ncatted -O -a experiment,global,o,c,"Model: $M" -h $temp_dir/base/temp_wspd.nc
        ncatted -O -a climate,global,o,c,"$C" -h $temp_dir/base/temp_wspd.nc
        ncatted -O -a project,global,o,c,"HiWAVES3" -h $temp_dir/base/temp_wspd.nc
        ncatted -O -a email,global,a,c,"l.p.stoop@uu.nl" -h $temp_dir/base/temp_wspd.nc
        ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for European region" -h $temp_dir/base/temp_wspd.nc
        ncatted -O -a short_name,wspd,o,c,"wspd" -h $temp_dir/base/temp_wspd.nc
        ncatted -a units,wspd,o,c,"m/s" -h $temp_dir/base/temp_wspd.nc $drive/HiWAVES3-${M}-${C}-EU_BASE/HiWAVES3-${M}-${C}-EU_wspd_s${S}r$R.nc

        # SSRD Base set             
        cdo chname,rsds,ssrd $temp_dir/merge/temp_rsds.nc $temp_dir/base/temp_ssrd.nc
        # Rename the attributes and set the variables attributes for solar radiation
        ncatted -O -a experiment,global,o,c,"Model: $M" -h $temp_dir/base/temp_ssrd.nc
        ncatted -O -a climate,global,o,c,"$C" -h $temp_dir/base/temp_ssrd.nc
        ncatted -O -a project,global,o,c,"HiWAVES3" -h $temp_dir/base/temp_ssrd.nc
        ncatted -O -a email,global,a,c,"l.p.stoop@uu.nl" -h $temp_dir/base/temp_ssrd.nc
        ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h $temp_dir/base/temp_ssrd.nc
        ncatted -O -a short_name,ssrd,o,c,"ssrd" -h $temp_dir/base/temp_ssrd.nc
        ncatted -a units,ssrd,o,c,"W/m^2" -h $temp_dir/base/temp_ssrd.nc $drive/HiWAVES3-${M}-${C}-EU_BASE/HiWAVES3-${M}-${C}-EU_ssrd_s${S}r$R.nc

        rm $temp_dir/base/temp_*.nc
        rm $temp_dir/merge/temp_*.nc
    done
done

