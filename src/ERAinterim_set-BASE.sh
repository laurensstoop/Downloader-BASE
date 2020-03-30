# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

### General stuff
# Write all output to a logfile
#logfile=1A_ECWMF-conversion_UERRA_$(timestamp).log
#exec 3>&1 1>>${logfile} 2>&1




### Setting everything up

# Set the generic name
fname="ERAinterim-EU_"

# Set the directories
dir_in="/media/stoop/DataDrive/ERAinterim/origin/"
dir_out="/media/stoop/DataDrive/ERAinterim/ERAinterim_BASE/"


### Running the loop
for Y in $(seq 1979 1979);do 
    # Update the reader & copy to log
#    echo "$(timestamp): ERAinterim Set BASE standard Start ${V} for year ${Y}" 1>&3 
    echo "$(timestamp): ERAinterim Set BASE standard Start ${V} for year ${Y}" # log

    # Do the Radiation component
    echo "$(timestamp): Radiation" # FIX THIS WITH integrated stuff
    cdo -b 32 setattribute,ssrd@units="W/m^2" -divc,10800. -chname,ssr,ssrd -select,name=ssr $dir_in$fname$Y.nc $dir_out${fname}ssrd_$Y.nc                

    # Do the Temperature
    echo "$(timestamp): Temperature"
    cdo -b 32 setattribute,t2m@units="degC" -addc,-273.15 -select,name=t2m $dir_in$fname$Y.nc $dir_out${fname}t2m_$Y.nc         

    # Do the windspeed
    echo "$(timestamp): Temperature"
    cdo -b 32 setattribute,wspd@units="m/s" -expr,'wspd=sqrt(u10*u10+v10*v10)' -select,name=u10,v10 $dir_in$fname$Y.nc $dir_out${fname}wspd_$Y.nc


done



echo "I (set the ERAinterim to the BASE stanard and I) am done!"
