# Made by Laurens Stoop, laurensstoop@pm.me

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}


months='01 02 03 04 05 06 07 08 09 10 11 12'

# Set the directories
dir_in='./merge/'
dir_out='./rename/'

for Y in $(seq 1980 2019);  
do 
    for M in $months;
    do
     
        # Rename the variables
        cdo chname,T2M,t2m,V50M,v50m,V10M,v10m,U50M,u50m,U10M,u10m,SWGDN,ssrd ${dir_in}MERRA2_$Y$M.nc ${dir_out}temp2.nc

        # Rename the attributes and set the variables attributes
        ncatted -O -a map_area,global,o,c,"Europe" -h ${dir_out}temp2.nc
        ncatted -O -a experiment,global,o,c,"Model: MERRA2" -h ${dir_out}temp2.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, laurensstoop@pm.me UU/TenneT/KNMI" -h ${dir_out}temp2.nc

        # Setting the new files
        ncks -h -A ${dir_out}temp2.nc ${dir_out}MERRA2-EU_$Y$M.nc

        # Clean up shit
        rm ${dir_out}temp*.nc

    done
done

