"""
Spyder Editor

Created on Wed 19 Jun 2019 14:00

@author: Laurens Stoop - l.p.stoop@uu.nl
"""
#%%
# =============================================================================
# Dependencies
# =============================================================================

# Get the dependencies
import numpy as np
import datetime
import os.path
import xarray as xr

# define the storage location
path_from = '/media/DataDrive/ERA5/origin_nc/'
path_save = '/media/DataDrive/ERA5/europe-land/'


# define the variables to run over (short name)
variable_names = [
        'wspd', 
        't2m', 
        'mpsl', 
        'ssrd'
        ]

# The years we want to download
years = [   
            '2001','2002','2003',
            '2004','2005','2006',
            '2007','2008','2009',
            '2010','2011','2012',
            '2013','2014','2015',
            '2016','2017','2018'
        ]



#%%
# =============================================================================
# Download loop
# =============================================================================

# Run over the years
for year in years:
        
    # Run over 5 numbers to get the data we want
    for i in np.arange(len(variable_names)):
        
        # Define the variable name we want to reset the info off
        var_name = variable_names[i]
        
        # Define the file name
        file_save = path_save+'ERA5-EU-land_'+var_name+'_'+year+'.nc'
        
        # Check if file exist to allow for easy redo
        if os.path.isfile(file_save) == True:
            
            # Tell us the file exist
            print('NOTIFY: this file was allready done (or still exists in target directory)! '+file_save)
        
        # if file doesn't exist, we download it
        elif os.path.isfile(file_save) == False:
            
            
            # Let's notify our terminal where we are!
            print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to make '+file_save)
            
            # =============================================================================
            # We Fix the units
            # =============================================================================
            print('NOTIFY (1/2): Loading and fixing units ...')
            
            # Catch the windspeed
            if var_name == 'wspd':
                
                # Open the data
                ds_a = xr.open_mfdataset(path_from+'ERA5-EU-land_u10_'+year+'.nc')
                ds_b = xr.open_mfdataset(path_from+'ERA5-EU-land_v10_'+year+'.nc')
                
                # We load the files
                ds_a.load()
                ds_b.load()
                
                # Set a new dataset
                ds= xr.Dataset()
                
                # Calculate the windspeed
                ds['wspd'] = np.sqrt(ds_a.u10**2 + ds_b.v10**2)
                
                # Fixing the broken time axis
                dt = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dt['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dt.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
                # rename the new time axis                
                ds2 = ds2.rename({'time_new':'time'})
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Now we select only the year we want (there is some overlap due to the timestep definition)
                ds2 = ds2.sel(time=slice(year+'-01-01', year+'-12-31'))
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                        
                        
                # update the units
                ds2.wspd.attrs.update(
                        long_name = '10 meter wind speed',
                        units = 'm s**-1')  
                
            # Catch the temperature
            elif var_name == 't2m':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU-land_t2m_'+year+'.nc')
            
                # We load the files
                ds.load()
                
                # Fixing the broken time axis
                dt = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dt['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dt.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
                # rename the new time axis                
                ds2 = ds2.rename({'time_new':'time'})
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Now we select only the year we want (there is some overlap due to the timestep definition)
                ds2 = ds2.sel(time=slice(year+'-01-01', year+'-12-31'))
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Rebase the variable
                ds2['t2m'] = ds2.t2m - 273.4
                                
                # update the units
                ds2.t2m.attrs.update(
                        units = 'degree C')
           
            # Catch the mean sea level pressure
            elif var_name == 'mpsl':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU-land_mpsl_'+year+'.nc')
            
                # We load the files
                ds.load()
                
                # Fixing the broken time axis
                dt = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dt['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dt.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
                # rename the new time axis                
                ds2 = ds2.rename({'time_new':'time'})
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Now we select only the year we want (there is some overlap due to the timestep definition)
                ds2 = ds2.sel(time=slice(year+'-01-01', year+'-12-31'))
                
                # Update the time variable attributes
                ds2.time.attrs.update(
                        long_name = 'time',
                        standard_name = 'time')
                
                # Rebase the variable
                ds2['mpsl'] = ds2.sp/1e2
                
                # Drop the old variable
                ds2 = ds2.drop('sp')
                
                # update the units
                ds2.mpsl.attrs.update(
                        units = 'hPa')
            
            # Catch the incoming solar radiation
            elif var_name == 'ssrd':
                
                # Open the file
                ds = xr.open_mfdataset(path_from+'ERA5-EU-land_'+var_name+'_'+year+'.nc')
            
                # We load the files
                ds.load()
                
                # Fixing the broken time axis
                dt = ds.stack(time_new = ['time','step']).reset_index('time_new')
                dt['time_new'] = ds.stack(time_new = ['time','step']).reset_index('time_new').valid_time
                                
                # We drop useless variables
                ds2 = dt.drop([ 'step', 'number', 'surface', 'valid_time', 'time'])
                
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
                    download_date = '3 aug 2019',
                    author = 'Laurens Stoop',
                    email = 'l.p.stoop@uu.nl',
                    affiliation = 'Utrecht University (UU) & Royal Dutch Meteorological Institute (KNMI) & TenneT')
                      
            
            # Save the file
            print('NOTIFY (2/2): Saving ...')
            ds2.to_netcdf(file_save, encoding={'time':{'units':'days since 1900-01-01'}})
            ds2.close()
            if var_name == 'wspd' or var_name =='wspd100m' or var_name =='fdif':
                ds_a.close()
                ds_b.close()
            else:    
                ds.close()

        
   
