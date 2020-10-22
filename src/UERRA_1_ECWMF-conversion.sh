# In this file the data is cut for netherlands
# Author: Laurens Stoop, UU/KNMI/TenneT

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

### General stuff
# Write all output to a logfile
logfile=1A_ECWMF-conversion_UERRA_$(timestamp).log
exec 3>&1 1>>${logfile} 2>&1




### Setting everything up
# SETUP
gcm='COSMO' # option = Harmonie (eswi), UM (egrr), COMSO (edzw)
type_of_model='enda' # option= prod/enda

# Set the directories
dir_in="/media/DataFiles/UERRA/origin/${gcm}/"
dir_out="/media/DataFiles/UERRA/origin_nc/${gcm}/"

# The variables to run over
models='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20' # ssrd t2m wspd'
years='2006 2007 2008 2009 2010'              #'1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018'
months='01 02 03 04 05 06 07 08 09 10 11 12'

### Running the loop
for E in ${models}
do
    for Y in ${years}
    do
        for M in ${months}
        do
    
            # Update the reader & copy to log
            echo "$(timestamp): UERRA Set file standard to NetCDF Start ${V} for year ${Y} & ${M} " 1>&3 
            echo "$(timestamp): UERRA Set file standard to NetCDF Start ${V} Year ${Y} & ${M}" # log
    
            # Set the generic name
            fname="UERRA-EU_${gcm}-${type_of_model}_${V}_${Y}-${M}"

            
            # Copy and store
            cdo -f nc copy ${dir_in}${fname}.grib ${dir_out}${fname}.nc
        done
    done
done


echo "I (the conversion script to NetCDF for UERRA data) am done!"
