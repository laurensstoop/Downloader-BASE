# define the storage location
file_in1='/media/DataGate2/ERA5/BASE2'
file_in2='/media/DataGate3/ERA5/origin'
file_out='/media/DataGate2/ERA5/origin'


months='01 02 03 04 05 06 07 08 09 10 11 12'
for Y in $(seq 1950 1979);do  
    for M in $months ; do
        cdo merge ${file_in1}/ERA5-EU_${Y}${M}.nc ${file_in2}/ERA5-EU_${Y}${M}.nc ${file_out}/ERA5-EU_${Y}${M}.nc
    done    
done