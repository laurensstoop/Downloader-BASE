# In this file the data is cut for netherlands
# Author: Laurens Stoop, UU/KNMI/TenneT

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

### General stuff
# Write all output to a logfile
logfile=1A_ECWMF-conversion_UERRA-cosmo_$(timestamp).log
exec 3>&1 1>>${logfile} 2>&1




# Set the directories
dir_in="/media/DataFiles/UERRA/origin/COSMO/"
dir_temp="/media/DataStager/UERRA/"
dir_out="/media/DataFiles/UERRA/origin_nc/COSMO/"

# The variables to run over
var='wspd' # ssrd t2m wspd'
moments='2006-06'  #2006-07 2007-01 2007-11 2008-02 2010-04 2010-09'

### Running the loop
for V in ${var}
do
    for M in ${moments}
        # Set the generic name
        fname="UERRA-EU_COSMO-enda_${V}_${M}"
    
        
        # Copy and store
        cdo -f nc copy ${dir_in}${fname}.gribp1 ${dir_temp}${fname}-p1.nc
        cdo -f nc copy ${dir_in}${fname}.gribp2 ${dir_temp}${fname}-p2.nc
        
        # merge the times
        cdo mergetime ${dir_temp}${fname}*.nc ${dir_temp}${fname}.nc
     done
done


echo "I (the conversion script to NetCDF for UERRA data) am done!"
