# In this file the data is cut for netherlands
# Author: Laurens Stoop, UU/KNMI/TenneT

### General stuff
# Write all output to a logfile
logfile=3A_CDS-Set_compliant_grid_$$.log
exec 3>&1 1>>${logfile} 2>&1

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}


### Setting everything up
# Set the directories
dir_in="/media/DataStager1/TEMP/ERA5/europe/"
dir_calc="/media/DataStager1/TEMP/ERA5/CDS/"
dir_out="/media/DataDrive/ERA5/ERA5-EU_BASE/"

# The variables to run over
var='t2m d2m rh' #'ssrd t2m wspd100m wspd fdif fdir mpsl d2m rh'
years='1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018'

# Generate a template for setting the grid according to conventions
cdo -f nc -random,n320 ${dir_calc}template.nc
cdo sellonlatbox,-31,74.25,34.5,80 ${dir_calc}template.nc ${dir_calc}template-EU.nc

### Running the loop
for V in ${var}
do
    for Y in ${years}
    do

        # Update the reader & copy to log
        echo "$(timestamp): EUROPE Set CF-1.7 grid standards Start ${V} for year ${Y} " 1>&3 
        echo "$(timestamp): EUROPE Set CF-1.7 grid standards Start ${V} Year ${Y}" # log

        # Set the generic name
        fname="ERA5-EU_${V}_${Y}.nc"

        # Rename the lat, lon dimensions
        ncrename -d longitude,lon -d latitude,lat -v longitude,lon -v latitude,lat ${dir_in}${fname} ${dir_calc}tmpERA1.nc

        # Reorder dimensions (with a normal latitude
        ncpdq -a time,-lat,lon ${dir_calc}tmpERA1.nc ${dir_calc}tmpERA2.nc

        # Set the grid to the N320 Grid with CF conventions
        cdo -setgrid,${dir_calc}template-EU.nc ${dir_calc}tmpERA2.nc ${dir_calc}tmpERAf.nc
       
        # Rename the attributes and set the variables attributes
        ncatted -O -a map_area,global,o,c,"Europe" -h ${dir_calc}tmpERAf.nc
        ncatted -O -a experiment,global,o,c,"Model: ERA5" -h ${dir_calc}tmpERAf.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ${dir_calc}tmpERAf.nc
        ncatted -O -a long_name,${V},o,c,"${V} masked for European region" -h ${dir_calc}tmpERAf.nc
        ncatted -O -a short_name,${V},o,c,"${V}" -h ${dir_calc}tmpERAf.nc
        ncatted -O -a history,global,d,, -h ${dir_calc}tmpERAf.nc

        # Setting the new files
        ncks -h -A ${dir_calc}tmpERAf.nc ${dir_out}${fname}

        # Clean up shit
        rm ${dir_calc}tmpERA*.nc
    done
done

# Clean the general files
rm ${dir_calc}template*.nc

echo "I (the correction to CF-1.7 compliant grid script for ERA5 data script) am done!"
