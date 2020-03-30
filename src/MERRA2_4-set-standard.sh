# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl

# Create a timestamp
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

years='1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019'

months='01 02 03 04 05 06 07 08 09 10 11 12'

# Set the directories
dir_in='./rename/'
dir_out='./EU/'


for Y in $(seq 1980 2019);
do 
    for M in $months;
    do
     
        # Calculate the 10m and 50m Windspeed
        cdo expr,'wspd=sqrt(u10m*u10m+v10m*v10m)' ${dir_in}MERRA2-EU_$Y$M.nc ${dir_out}wspd.nc
        cdo expr,'wspd50m=sqrt(u50m*u50m+v50m*v50m)' ${dir_in}MERRA2-EU_$Y$M.nc ${dir_out}wspd50m.nc

        # Merger of the ssrd, t2m from input and the new windspeeds to an output
        cdo merge -select,name=ssrd,t2m ${dir_in}MERRA2-EU_$Y$M.nc ${dir_out}wspd.nc ${dir_out}wspd50m.nc ${dir_out}wspd_merger.nc


        # set the units for the windspeeds for 10m
        ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meters" -h ${dir_out}wspd_merger.nc
        ncatted -O -a short_name,wspd,o,c,"wspd" -h ${dir_out}wspd_merger.nc
        ncatted -O -a units,wspd,o,c,"m s-1" -h ${dir_out}wspd_merger.nc 
        
        # set the units for the windspeeds
        ncatted -O -a long_name,wspd50m,o,c,"Wind speed at 50 meters" -h ${dir_out}wspd_merger.nc
        ncatted -O -a short_name,wspd50m,o,c,"wspd50m" -h ${dir_out}wspd_merger.nc
        ncatted -a units,wspd50m,o,c,"m s-1" -h ${dir_out}wspd_merger.nc ${dir_out}MERRA2-EU_$Y$M.nc

        # Clean up shit
        rm ${dir_out}wspd*.nc

    done
done

