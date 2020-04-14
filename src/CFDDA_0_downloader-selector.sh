# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
# Modified from UCAR standard script and added specific data extractor
#
# authenticate - NOTE: You should only execute this command ONE TIME.
# Executing this command for every data file you download may cause
# your download privileges to be suspended.
wget $cert_opt -O auth_status.rda.ucar.edu --save-cookies auth.rda.ucar.edu.$$ --post-data="email=l.p.stoop@uu.nl&passwd=$1&action=login" https://rda.ucar.edu/cgi-bin/login
#
# download the file(s)
# NOTE:  if you get 403 Forbidden errors when downloading the data files, check
#        the contents of the file 'auth_status.rda.ucar.edu'

#stage='/media/stoop/DataStager'
stage='/home/stoop'

# The main loop prep
hours='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23'
days='01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31'
months='01 02 03 04 05 06 07 08 09 10 11 12'
#years='1988 1989 1991 1992 1993 1994 1996 1997 1998 1999 2001 2002 2003 2004 2005'
# run in chunks of 5 years (1985--2005)
for Y in $(seq 1985 2005) ;do
    for M in $months ;do

        # test if the file exist for the monthly data if not, then run montly bit
        if [ -e /media/stoop/DataFiles/CFDDA/merge/cfdda_merge_$Y$M.nc ]; then
            echo "File exists for $Y-$M"
        else 
            for D in $days ;do
                for H in $hours ;do
                    if [ -e $stage/TEMP/CFDDA/vars/cfdda_vars_$Y$M$D$H.nc ]; then
                        echo "File exists for day and hour $Y-$M-$D:$H"
                    else
                        # The brackets make it that the follow-up is only done if the fetch works
                        {
                        # Download the file with all the variables (can't sub-select on the server)
                        wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds604.0/$Y/$M/cfdda_$Y$M$D$H.v2.nc &&
                        # Select only the variables of interest
                        cdo select,name=T2C,V10,U10,swdown cfdda_$Y$M$D$H.v2.nc $stage/TEMP/CFDDA/vars/cfdda_vars_$Y$M$D$H.nc &&
                        # Remove the original file (to much diskspace needed)
                        rm cfdda_$Y$M$D$H.v2.nc
                        }
                    fi
                done
            done
            {
            # Merge the hours for a month in a file
            cdo -b 32 mergetime $stage/TEMP/CFDDA/vars/cfdda_vars_$Y$M*.nc /media/stoop/DataFiles/CFDDA/merge/cfdda_merge_$Y$M.nc &&
            #Now delete previous
            rm $stage/TEMP/CFDDA/vars/cfdda_vars_$Y$M*.nc
            }
        fi 
    done
done

#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
