"""
Spyder Editor

Created on Tue 21 Jan 2020 16:02

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


# SETUP [done: ]
gcm='Harmonie' # option = Harmonie (eswi), UM (egrr)
type_of_model='fc' # option= fc/an

# define the storage location
path_from = '/media/stoop/DataFiles/UERRA/origin_nc/'+gcm+'/'


# set the save path
path_save = '/media/stoop/DataFiles/UERRA/EU/'+gcm+'/'


# define the variables to run over (short name)
variable_names = [
        'wspd',
        't2m',
        'ssrd'
        ]

# The years we want to clean
years = [
#        '1961', '1962', '1963', '1964', '1965', '1966', '1967', '1968', '1969', '1970', 
#         '1971', '1972', '1973', '1974', '1975', '1976', '1977', '1978', '1979', '1980', 
#         '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989', '1990', 
#         '1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999', '2000', 
#         '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', 
#         '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'
        '2019'
         ]

months =    [  
            '01', '02', '03', 
            '04', '05', '06', 
            '07'
#            , '08', '09', 
#            '10', '11', '12'
            ]

#%%
# =============================================================================
# Download loop
# =============================================================================

# Run over the years
for year in years:
    
    for month in months: 
        
        # Run over 5 numbers to get the data we want
        for i in np.arange(len(variable_names)):
            
            # Define the variable name we want to reset the info off
            var_name = variable_names[i]
            
            # Define the file name
            file_name = 'UERRA-EU_'+gcm+'-'+type_of_model+'_'+var_name+'_'+year+'-'+month
            
            
            # Check if file exist to allow for easy redo
            if os.path.isfile(path_save+file_name+'.nc') == True:
                
                # Tell us the file exist
                print('NOTIFY: this file was allready done (or still exists in target directory)! '+file_name)
            
            # if file doesn't exist, we download it
            elif os.path.isfile(path_save+file_name+'.nc') == False:
                
                
                # Let's notify our terminal where we are!
                print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to make '+file_name)
                
                # =============================================================================
                # We Fix the units
                # =============================================================================
                print('NOTIFY (1/2): Loading and fixing units ...')
                
                # Catch the windspeed
                if var_name == 'wspd':
                    
                    # Open the data
                    ds = xr.open_dataset(path_from+file_name+'.nc')
                                    
                    # We load the files
                    ds.load()
                    
                    # Set a new dataset
                    ds2= xr.Dataset()
                    
                    # Calculate the windspeed
                    ds2['wspd'] = ds['10si'].sel(height=10)
                    
                    ds2 = ds2.drop(['height'])
                    
                    # Update the time variable attributes
                    ds2.time.attrs.update(
                            long_name = 'time',
                            standard_name = 'time')
                            
                
                   
                # Catch the (dewpoint) temperature
                elif var_name == 't2m':
                    
                    # Open the file
                    ds = xr.open_dataset(path_from+file_name+'.nc')
                
                    # We load the files
                    ds.load()
                    
                    # Set a new dataset
                    ds2= xr.Dataset()
                    
                    # Rebase the variable
                    ds2[var_name] = ds['2t'].sel(height=2) - 273.4
                    
                    # We drop useless variables
                    ds2 = ds2.drop([ 'height'])
                    
                    # Update the time variable attributes
                    ds2.time.attrs.update(
                            long_name = 'time',
                            standard_name = 'time')
                                    
                    # update the units
                    ds2[var_name].attrs.update(
                            units = 'degree C')
                                  
                # Catch the incoming solar radiation
                elif var_name == 'ssrd':
                    
                    # Open the file
                    ds = xr.open_dataset(path_from+file_name+'.nc')
                
                    # We load the files
                    ds.load()
                    
                    # Set a new dataset
                    ds2 = xr.Dataset()
                    
                    # Rebase the variable
                    ds2[var_name] = ds['ssrd']/3600
                    
                    # Update the time variable attributes
                    ds2.time.attrs.update(
                            long_name = 'time',
                            standard_name = 'time')
                                    
                                      
                    # update the units
                    ds2.ssrd.attrs.update(
                            units = 'W m**-2')
                    
                
                    
    
                
                
                # Update the general definitions
                ds2.attrs.update(
                        download_date = '21 jan 2020',
                        author = 'Laurens Stoop',
                        email = 'l.p.stoop@uu.nl',
                        affiliation = 'Utrecht University (UU) & Royal Dutch Meteorological Institute (KNMI) & TenneT')
                          
                
                # Save the file
                print('NOTIFY (2/2): Saving ...')
                ds2.to_netcdf(path_save+file_name+'.nc', encoding={'time':{'units':'days since 1900-01-01'}})
                ds2.close()
                ds.close()
    
            
       