# -*- coding: utf-8 -*-
"""
Spyder Editor

Created on Wed 30 Apr 2019 14:16

@author: Laurens Stoop - l.p.stoop@uu.nl
"""


#%%
# =============================================================================
# Dependencies
# =============================================================================

# Get the dependencies
import numpy as np
import datetime as dt
import os.path
import xarray as xr

# define the storage location
path_from = '/media/stoop/DataDrive/ERA5/origin/'
path_save = '/media/stoop/DataDrive/ERA5/europe/'

## define the variables to run over (long name)
variables = [   
            '10m_wspd_component_of_wind',
            '100m_wspd_component_of_wind',
            '2m_temperature',
            'mean_sea_level_pressure',
            'surface_solar_radiation_downwards',
            'total_sky_direct_solar_radiation_at_surface'
            ]
# define the variables to run over (short name)
variable_names = [
        'wspdsrf', 
        'wspd100', 
        't2m', 
        'mpsl', 
        'ssrd',
        'fdir'
        ]

# The years we want to download
years = [   
            '1979','1980','1981',
            '1982','1983','1984',
            '1985','1986','1987',
            '1988','1989','1990',
            '1991','1992','1993',
            '1994','1995','1996',
            '1997','1998','1999',
            '2000','2001','2002',
            '2003','2004','2005',
            '2006','2007','2008',
            '2009','2010','2011',
            '2012','2013','2014',
            '2015','2016','2017',
            '2018'
        ]



#%%
# =============================================================================
# Download loop
# =============================================================================

# Run over the years
for year in years:
        
    # Run over 5 numbers to get the data we want
    for i in np.arange(len(variables)):
        
        # Define the variable name we want to download
        variable = variables[i]
        var_name = variable_names[i]
        
        # Define the file name
        file_save = path_save+'ERA5-EU_'+var_name+'_'+year+'.nc'
        
        # Check if file exist to allow for easy redo
        if os.path.isfile(file_save) == True:
            
            # Tell us the file exist
            print('NOTIFY: this file was allready done! '+file_save)
        
        # if file doesn't exist, we download it
        elif os.path.isfile(file_save) == False:
            
            
            # Let's notify our terminal where we are!
            print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to make '+file_save)
            
            # Catch the 10m windspeed
            if var_name == 'wspdsrf':
                            
                # We open the files from ERA5 download folder
                ds_u = xr.open_mfdataset(path_from+'ERA5-EU_u10_'+year+'*.nc')
                ds_v = xr.open_mfdataset(path_from+'ERA5-EU_v10_'+year+'*.nc')
                
                # We load it into memory
                print('NOTIFY (1/4): Load u10')
                ds_u.load()
                print('NOTIFY (2/4): Load v10')
                ds_v.load()
                
                # Now we make a new variable
                print('NOTIFY (3/4): Calculate windspeed at surface [wspdsrf]')
                ds = xr.Dataset()
                ds[var_name] = (ds_u['u10']**2 + ds_v['v10']**2)**(1/2) 
                
                # Set the properties
                ds.attrs = ds_u.attrs
                ds.wspdsrf.attrs.update(
                        units = ds_u.u10.attrs['units'],
                        long_name = variable)
                
                # Save the file
                print('NOTIFY (4/4): Saving...')
                ds.to_netcdf(file_save)
                
                # Closing the files
                ds_u.close()
                ds_v.close()
                ds.close()
                
            # Catch the 100m windspeed
            elif var_name == 'wspd100':
                            
                # We open the files from ERA5 download folder
                ds_u = xr.open_mfdataset(path_from+'ERA5-EU_u100m_'+year+'*.nc')
                ds_v = xr.open_mfdataset(path_from+'ERA5-EU_v100m_'+year+'*.nc')
                
                # We load it into memory
                print('NOTIFY (1/4): Load u100')
                ds_u.load()
                print('NOTIFY (2/4): Load v100')
                ds_v.load()
                
                # Now we make a new variable
                print('NOTIFY (3/4): Calculate windspeed at height [wspd100]')
                ds = xr.Dataset()
                ds[var_name] = (ds_u['u100']**2 + ds_v['v100']**2)**(1/2) 
                
                # Set the properties
                ds.attrs = ds_u.attrs
                ds.wspd100.attrs.update(
                        units = ds_u.u100.attrs['units'],
                        long_name = variable)
                
                # Save the file
                print('NOTIFY (4/4): Saving...')
                ds.to_netcdf(file_save)
                
                # Closing the files
                ds_u.close()
                ds_v.close()
                ds.close()
            
            # Set the radiation variables to W/m2
            elif var_name == 'ssrd' or var_name == 'fdir':
                            
                # We open the files
                print('NOTIFY (1/3): Get the file')
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'*.nc')
                
                # We load the files
                ds.load()
                
                # We rescale the variables to W/m2
                print('NOTIFY (2/3): Setting radiation to Watts')
                ds[var_name] = ds[var_name]/3600.
                ds = ds.where(ds.fdir >=0., 0.)                
                
                # Update the variables
                ds[var_name].attrs.update(units = 'W/m**-2')
                
                # Save the file
                print('NOTIFY (3/3): Saving ...')
                ds.to_netcdf(file_save)
                ds.close()
            
            # Now we do the other files
            else:
                
                # We open the files
                print('NOTIFY (1/2): Get the file')
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'*.nc')
                
                # We load the files
                ds.load()
                
                # Save the file
                print('NOTIFY (2/2): Saving ...')
                ds.to_netcdf(file_save)
                ds.close()