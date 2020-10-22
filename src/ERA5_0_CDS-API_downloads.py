# -*- coding: utf-8 -*-
"""
Spyder Editor

Created on Wed 06 Mar 2019 16:54

@author: Laurens Stoop - l.p.stoop@uu.nl
"""


#%%
# =============================================================================
# Dependencies
# =============================================================================

# Get the dependencies
import cdsapi
import numpy as np
import datetime as dt
import os.path

# define the storage location
#file_path = '/media/DataDrive/ERA5/origin/'
file_path = '/media/DataStager1/TEMP2/ERA5/origin/'

# define the variables to run over (long name)
variables = [   
            # 'forecast_albedo', 
            'forecast_surface_roughness',
            '2m_dewpoint_temperature',
            # '10m_u_component_of_wind',
            # '10m_v_component_of_wind',
            # '100m_u_component_of_wind',
            # '100m_v_component_of_wind',
            # '2m_temperature',
            # 'mean_sea_level_pressure',
            # 'surface_solar_radiation_downwards',
            # 'total_sky_direct_solar_radiation_at_surface'
            ]
# define the variables to run over (short name)
variable_names = [
        # 'fal',
        'fsr',
        'd2m',
        # 'u10', 
        # 'v10', 
        # 'u100m', 
        # 'v100m', 
        # 't2m', 
        # 'mpsl', 
        # 'ssrd',
        # 'fdir'   
        ]

# The years we want to download
years = [   
            # '1979','1980','1981',
            # '1982','1983','1984',
            # '1985','1986','1987',
            # '1988','1989','1990',
            # '1991','1992','1993',
            # '1994','1995','1996',
            # '1997','1998','1999',
            # '2000','2001','2002',
            # '2003','2004','2005',
            # '2006','2007','2008',
            # '2009','2010','2011',
            # '2012','2013','2014',
            # '2015','2016','2017',
            # '2018'
            '2019'
        ]

# The format of the data
FORMAT = 'GRIB'


def download_function(V, Y, F):
    
        # The retrieve function
    c.retrieve(
        # Dataset to download (reanalysis at a single level)
        'reanalysis-era5-single-levels',  
        {
            # Variable selection based on input
            'variable':V,
            # Specific data type (reanalysis or ensemble)
            'product_type':'reanalysis',  
            # The year to download
            'year':Y,  
            # The months to download
            'month':[
                '01','02','03',
                '04','05','06',
                '07','08','09',
                '10','11',
                '12'
            ],
            # The days to download
            'day':[
                '01','02','03',
                '04','05','06',
                '07','08','09',
                '10','11','12',
                '13','14','15',
                '16','17','18',
                '19','20','21',
                '22','23','24',
                '25','26','27',
                '28','29','30',
                '31'
            ],
            # The timesteps to download
            'time':[
                '00:00','01:00','02:00',
                '03:00','04:00','05:00',
                '06:00','07:00','08:00',
                '09:00','10:00','11:00',
                '12:00','13:00','14:00',
                '15:00','16:00','17:00',
                '18:00','19:00','20:00',
                '21:00','22:00','23:00'
            ],
            # The area to download base don degrees (North, West, South, East. Default: global)
            'area'    : '80/-31/34.5/74.25',
            # Data format to download (Default: GRIB) use netcdf
            'format':FORMAT
        },
        # Use the predefined name to download the data
        F)

#%%
# =============================================================================
# Download loop
# =============================================================================

# Make a shortcut for the CDS download client
c = cdsapi.Client()

# Run over the years
for year in years:

        
    # Run over 5 numbers to get the data we want
    for i in np.arange(len(variables)):
        
        # Define the variable name we want to download
        variable = variables[i]
        var_name = variable_names[i]
        
        # Define the file name
        if FORMAT =='netcdf': 
            file = file_path+'ERA5-EU_'+var_name+'_'+year+'.nc'
        elif FORMAT == 'GRIB':
            file = file_path+'ERA5-EU_'+var_name+'_'+year+'.grib'
        
        # Check if file exist to allow for easy redo
        if os.path.isfile(file) == True:
            
            # Tell us the file exist
            print('NOTIFY: this file was allready done! '+file)
        
        # if file doesn't exist, we download it
        elif os.path.isfile(file) == False:
                   
            # Let's notify our terminal where we are!
            print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to retrieve '+file)
            
            # The attempt loop (added due to server time-out issues)
            for attempt in np.arange(3):
            
                # This is what should be done
                try:
        
                    # download based on preset
                    download_function(V=variable, Y=year, F=file)
                    
                # if we get the HTTPError due to timing issues (file allready removed from server, we try again after notifications)
                except:
                    
                    # Notify that is went wrong
                    print('NOTIFY: Shit went wrong, we retry! Attempt '+str(attempt))
                
                # this is the escape line out of this loop after the attempts fail
                else:
                    
                    # Breaks after 3 attempts
                    break
                