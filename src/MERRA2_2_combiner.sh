# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl

months='01 02 03 04 05 06 07 08 09 10 11 12'

for Y in $(seq 1980 2019); 
do 
    for M in $months;
    do
        # Merge time on monthly level for surface and radiation components
        cdo mergetime ./origin/MERRA2_tavg1_2d_slv_Nx.$Y$M*.nc4 ./merge/slv$Y$M.nc4; 
        cdo mergetime ./origin/MERRA2_tavg1_2d_lfo_Nx.$Y$M*.nc4 ./merge/lfo$Y$M.nc4;

        # merge files
        cdo merge ./merge/slv$Y$M.nc4 ./merge/lfo$Y$M.nc4 ./merge/MERRA2_$Y$M.nc;

        # delete temp files
        rm ./merge/slv$Y$M.nc4;
        rm ./merge/lfo$Y$M.nc4;

    done
done

