#!/bin/bash
# In this file the data is cut for netherlands
# Author: Laurens Stoop, UU/KNMI/TenneT

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}


### Setting everything up
# Set the directories
dir_in=$1  # "/media/DataStager1/ERA5/temp/"
dir_out=$2 # "/media/DataDrive/ERA5BE-EU_BASE/"
#dir_out="/media/DataDrive/ERA5/ERA5-EU_BASE/"

# The variables to run over
var=$3 #'ssrd t2m wspd100m wspd fdif fdir mpsl d2m rh fal fsr sro ro'
years=$4 # '1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019' 

# Generate a template for setting the grid according to conventions
#cdo -f nc -random,n320 ${dir_in}template.nc
#cdo sellonlatbox,-31,74.25,34.5,80 ${dir_in}template.nc ${dir_in}template-EU.nc
# alternatively set a temp.nc file by using seltimestep on a correct coords file and use this as the template

### Running the loop
for V in ${var}
do
    for Y in ${years}
    do

        # Update the reader & copy to log
        #echo "$(timestamp): EUROPE Set CF-1.7 grid standards Start ${V} for year ${Y} " 1>&3 
        echo "$(timestamp): EUROPE Set CF-1.7 grid standards Start ${V} Year ${Y}" # log

        # Set the generic name
        fname="ERA5-EU_${V}_${Y}.nc"

        # Rename the lat, lon dimensions
        echo "Rename lat, lon"
        ncrename -d longitude,lon -d latitude,lat -v longitude,lon -v latitude,lat ${dir_in}${fname} ${dir_in}tmpERA${V}${Y}1.nc

        # Reorder dimensions (with a normal latitude
        echo "Reorder the dimenstions"
        ncpdq -a time,-lat,lon ${dir_in}tmpERA${V}${Y}1.nc ${dir_in}tmpERA${V}${Y}12.nc

        # Set the grid to the N320 Grid with CF conventions
        echo "Set the grid to the defined one"
        cdo -setgrid,${dir_in}template-EU.nc ${dir_in}tmpERA${V}${Y}12.nc ${dir_in}tmpERA${V}${Y}f_${V}.nc
       
        # Rename the attributes and set the variables attributes
        ncatted -O -a map_area,global,o,c,"Europe" -h ${dir_in}tmpERA${V}${Y}f_${V}.nc
        ncatted -O -a experiment,global,o,c,"Model: ERA5" -h ${dir_in}tmpERA${V}${Y}f_${V}.nc
        ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h ${dir_in}tmpERA${V}${Y}f_${V}.nc
        ncatted -O -a history,global,d,, -h ${dir_in}tmpERA${V}${Y}f_${V}.nc

        # Setting the new file name and directory
        ncks -h -A ${dir_in}tmpERA${V}${Y}f_${V}.nc ${dir_out}${fname}

        # Clean up shit
        rm ${dir_in}tmpERA${V}${Y}*.nc
        rm ${dir_in}${fname}
    done
done


rm $
# Clean the general files
#rm ${dir_in}template*.nc

echo "I (the correction to CF-1.7 compliant grid script for ERA5 data script) am done!"
