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
path_from = '/media/DataDrive/ERA5/origin/'
path_save = '/media/DataDrive/ERA5/origin_nc/'


# define the variables to run over (short name)
variable_names = [
        'u10',
        'v10',
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
        
        # Define the variable name we want to work with
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
            print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to make '+file_save)
          
                
            # We open the files
            print('NOTIFY (1/2): Get the file')
            ds = xr.open_mfdataset(path_from+'ERA5-EU-land_'+var_name+'_'+year+'.grib', engine='cfgrib', decode_cf=True)
            
            # We load the files
            ds.load()
            
            # Save the file
            print('NOTIFY (2/2): Saving ...')
            ds.to_netcdf(file_save, encoding={'time':{'units':'days since 1900-01-01'}})
            ds.close()