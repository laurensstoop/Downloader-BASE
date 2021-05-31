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
import subprocess

# define the storage location
path_from = '/media/DataStager1/ERA5/origin/'
path_save = '/media/DataStager1/ERA5/temp/'
path_store = '/media/DataStager1/ERA5/store/'
# path_store = '/media/DataDrive/ERA5BE-EU_BASE/'


# define the variables to run over (short name)
variable_names = [
        'ssrd', 
        't2m', 
        'wspd', 
        'wspd100m', 
        'mpsl', 
        'ro',
        'sro',
        'd2m'
        ]

# The years we want to clean
years = [ 
            # '1950', '1951', '1952',
            # '1953', '1954', '1955',
            # '1956', '1957', '1958',
            # '1959', '1960', '1961',
            # '1962', '1963', '1964',
            # '1965', '1966', '1967',
            # '1968', '1969', '1970',
            # '1971', '1972', '1973',
            # '1974', '1975', '1976',
            # '1977', '1978',
            # '1979', '1980', '1981',
            # '1982', '1983', '1984',
            # '1985', '1986', '1987',
            # '1988', '1989', '1990',
            # '1991', '1992', '1993',
            # '1994', '1995', '1996',
            # '1997', '1998', '1999',
            # '2000', '2001', '2002',
            # '2003', '2004', '2005',
            # '2006', '2007', '2008',
            # '2009', '2010', '2011',
            # '2012', '2013', '2014',
            # '2015', '2016', '2017',
            # '2018', '2019', 
            '2020'     
        ]



#%%
# =============================================================================
# Download loop
# =============================================================================

# Run over the years
for year in years:
        
    # Run over variables to get the data we want
    for i in np.arange(len(variable_names)):
        
        # Define the variable name we want to work with
        var_name = variable_names[i]
        
        # Define the file name
        file_save = path_save+'ERA5-EU_'+var_name+'_'+year+'.nc'
        file_store = path_store+'ERA5-EU_'+var_name+'_'+year+'.nc'
        
        # Check if file exist to allow for easy redo
        if os.path.isfile(file_store) == True:
            
            # Tell us the file exist
            print('NOTIFY: this file was allready done (or still exists in target directory)! '+file_save)
        
        # if file doesn't exist, we download it
        elif os.path.isfile(file_save) == False:
            
            
            # Let's notify our terminal where we are!
            print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to make '+file_save)

             # =============================================================================
            # We Fix the units
            # =============================================================================
            print('NOTIFY (1/3): Loading and fixing units ...')
            
            # Catch the windspeed
            if var_name == 'wspd':
                
                # Open the data
                ds_a = xr.open_mfdataset(path_from+'ERA5-EU_u10_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
                ds_b = xr.open_mfdataset(path_from+'ERA5-EU_v10_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
                
                # We load the files
                ds_a.load()
                ds_b.load()
                
                # Set a new dataset
                ds= xr.Dataset()
                
                # Calculate the windspeed
                ds['wspd'] = np.sqrt(ds_a.u10**2 + ds_b.v10**2)
                
                ds2 = ds.drop([ 'step', 'number', 'surface', 'valid_time'])
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                        
                        
                # update the units
                ds2.wspd.attrs.update(
                        long_name = '10 meter wind speed',
                        units = 'm s**-1')  
                
                        
            
            # Catch the higher up windspeed
            elif var_name == 'wspd100m':
                
                # Open the datas
                ds_a = xr.open_mfdataset(path_from+'ERA5-EU_u100m_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
                ds_b = xr.open_mfdataset(path_from+'ERA5-EU_v100m_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
                                
                # We load the files
                ds_a.load()
                ds_b.load()
                
                # Set a new dataset
                ds = xr.Dataset()
                
                # Calculate the windspeed
                ds['wspd100m'] = np.sqrt(ds_a.u100**2 + ds_b.v100**2)
                                
                # Drop the uselessness
                ds2 = ds.drop([ 'step', 'number', 'surface', 'valid_time'])
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')                        
                        
                # update the units
                ds2.wspd100m.attrs.update(
                        long_name = '100 meter wind speed',
                        units = 'm s**-1')
                
            # Catch the (dewpoint) temperature
            elif var_name == 't2m' or var_name == 'd2m':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
            
                # We load the files
                ds.load()
                
                # We drop useless variables
                ds2 = ds.drop([ 'step', 'number', 'surface', 'valid_time'])
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Rebase the variable
                ds2[var_name] = ds2[var_name] - 273.4
                                
                # update the units
                ds2[var_name].attrs.update(
                        units = 'degree C')
                
                # Catch therunoff and surface runoff
            elif var_name ==  'ro' or var_name ==  'sro':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
            
                
                # Fixing the broken time axis
                dtime = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dtime['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dtime.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
                # rename the new time axis                
                ds2 = ds2.rename({'time_new':'time'})
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Now we select only the year we want (there is some overlap due to the timestep definition)
                ds2 = ds2.sel(time=slice(year+'-01-01', year+'-12-31'))
                
            # Catch the mean sea level pressure
            elif var_name == 'mpsl':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
            
                # We load the files
                ds.load()
                
                # We drop useless variables
                ds2 = ds.drop([ 'step', 'number', 'surface', 'valid_time'])
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Rebase the variable
                ds2['mpsl'] = ds2.msl/1e2
                
                # Drop the old variable
                ds2 = ds2.drop('msl')
                
                # update the units
                ds2.mpsl.attrs.update(
                        units = 'hPa')
            
            # Catch the incoming solar radiation
            elif var_name == 'ssrd':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU_'+var_name+'_'+year+'.grib',combine='by_coords', engine='cfgrib', decode_cf=True)
            
                # We load the files
                ds.load()
                
                # Fixing the broken time axis
                dtime = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dtime['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dtime.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
                # rename the new time axis                
                ds2 = ds2.rename({'time_new':'time'})
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Now we select only the year we want (there is some overlap due to the timestep definition)
                ds2 = ds2.sel(time=slice(year+'-01-01', year+'-12-31'))
                
                # Rename the variable
                ds2[var_name] = ds2[var_name]/3600.
                                
                # update the units
                ds2[var_name].attrs.update(
                        units = 'W m**-2')
                
                       
            # Update the general definitions
            ds2.attrs.update(
                    download_date = '10 nov 2020',
                    author = 'Laurens Stoop',
                    email = 'l.p.stoop@uu.nl',
                    affiliation = 'Utrecht University (UU) & Royal Dutch Meteorological Institute (KNMI) & TenneT')
                      
            
            # Save the file
            print('NOTIFY (2/3): Saving netcdf file with correct units')
            ds2.to_netcdf(file_save, encoding={'time':{'units':'days since 1900-01-01'}})
            ds2.close()
            if var_name == 'wspd' or var_name =='wspd100m':
                ds_a.close()
                ds_b.close()
            else:    
                ds.close()

                        

            print('NOTIFY (3/3): Fixing the grid and storing data')
            # =============================================================================
            # Now we run subprocess of clean & compliant grid            
            # =============================================================================
            
            # We call the subprocess
            # subprocess.call("/home/stoop/Documents/Project/Downloader-BASE/src/ERA5_2_grid.sh %s %s %s %s" %(path_save, path_store, var_name, year), shell=True)
            
            # let the user know
            print('NOTIFY: Finished for '+var_name+' in '+year)
        
   