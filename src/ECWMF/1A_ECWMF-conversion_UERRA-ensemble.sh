# In this file the data is cut for netherlands
# Author: Laurens Stoop, UU/KNMI/TenneT

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}


### Setting everything up
# SETUP
gcm='COSMO' # option = Harmonie (eswi), UM (egrr), COMSO (edzw)
type_of_model='enda' # option= prod/enda

# Set the directories
dir_in="/media/stoop/DataFiles/UERRA/origin/${gcm}/"
dir_out="/media/stoop/DataFiles/UERRA/origin_nc/${gcm}/"

# The variables to run over
models='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20' 
years='2010' # 2007 2008 2009 2010'              
months='01 02 03 04 05 06 07 08 09 10 11 12'

### Running the loop
for E in ${models}
do
    for Y in ${years}
    do
        for M in ${months}
        do
    
            # Update the reader & copy to log
            echo "$(timestamp): UERRA Set file standard to NetCDF Start model ${E} Year ${Y} & ${M}" # log
    
            # Set the generic name
            fname="M${E}/UERRA-EU_${gcm}-${type_of_model}_M${E}_${Y}-${M}"

            
            # Copy and store
            cdo -f nc copy ${dir_in}${fname}.grib ${dir_out}${fname}.nc
        done
    done
done


echo "I (the conversion script to NetCDF for UERRA data) am done!"
