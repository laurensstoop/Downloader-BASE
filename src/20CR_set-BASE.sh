# Laurens Stoop l.p.stoop@uu.nl
#
# 

### Run in the origin folder the following commandline
for filename in ./air* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename.nc
done 
for filename in ./dswrf* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename.nc
done 
for filename in ./uwnd* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename.nc
done 
for filename in ./vwnd* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename.nc
done 








### Run in the Vars folder
for Y in '1958' ;do # 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018'
    # Fix the variables for the radiation
    cdo chname,dswrf,ssrd dswrf.sfc.$Y.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc

    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Downward short-wave radiation flux masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"ssrd" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
done

for Y in '1958' ;do # 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018'
    # Fix the variables for the temperature
    cdo chname,air,t2m -addc,-273.15 dswrf.sfc.$Y.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
done

for Y in '1958' ;do # 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018'

    # Fix the variables for the windspeed
    cdo chname,uwnd,wspd -sqrt -add -sqr uwnd.10m.$Y.nc -sqr vwnd.10m.$Y.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Windspeed at 10 meter masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
done


