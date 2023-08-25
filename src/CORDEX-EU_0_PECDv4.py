# -*- coding: utf-8 -*-
"""
Spyder Editor

Created on Tue 05 Jan 2021 17:34

@author: Laurens Stoop - l.p.stoop@uu.nl
"""

# to unpack all files after download use: for z in ./origin/*.zip; do unzip "$z" -d ./unpack/; done
    


#%%
# =============================================================================
# Dependencies
# =============================================================================

# Get the dependencies
import cdsapi
import datetime as dt
import os.path
import numpy as np

#%%
# =============================================================================
# Run definitions
# =============================================================================

"""
Combo's used (only used combo's that have all scenario's available in one experiment)

- ICHEC-EC-EARTH & KNMI-RACMO22E & RCP4.5

"""

GCM_model = 'ichec_ec_earth'  # ichec_ec_earth, mohc_hadgem2_es, cnrm_cerfacs_cm5, mpi_esm_lr, ncc_noresm1_m
RCM_model = 'knmi_racmo22e' # smhi_rca4, knmi_racmo22e, dmi_hirham5, gerics_remo2015
ENSEMBLE_member = 'r1i1p1'


# define the storage location
file_path = '/media/DataGate1/CORDEX-EU/origin_EC_RACMO/'

# Specific sub-experiment
EXPERIMENT ='historical' # 'historical' 'rcp_2_6' 'rcp_4_5' 'rcp_8_5'

if EXPERIMENT == 'historical':
    YEARS = np.arange(1951,2006,5)
else: 
    YEARS = np.arange(2006,2100,5)


#%%
# =============================================================================
# Download loop
# =============================================================================

# Make a shortcut for the CDS download client
c = cdsapi.Client()

# Run over the years
for year in YEARS:

    # Let's notify our terminal where we are!
    print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to retrieve '+str(year))
    
    
    
    # Retrieve SSRD
    file=file_path+'CORDEX-EU_'+EXPERIMENT+'_500hPaGeopot_'+str(year)+'.zip'
    
    # Check if file exist to allow for easy redo
    if os.path.isfile(file) == True:
        
        # Tell us the file exist
        print('NOTIFY: this file was allready done! '+file)
    
    # if file doesn't exist, we download it
    elif os.path.isfile(file) == False:
        c.retrieve(
            'projections-cordex-domains-single-levels',
            {
                'format': 'zip',
                'domain': 'europe',
                'experiment': EXPERIMENT,
                'horizontal_resolution': '0_11_degree_x_0_11_degree',
                'variable': '500hpa_geopotential_height',
                'gcm_model': GCM_model,
                'rcm_model': RCM_model,
                'ensemble_member': ENSEMBLE_member,
                'temporal_resolution': 'daily_mean',
                'start_year': str(year),
                'end_year': str(year+4),
            },
            file)

    # # Retrieve temperature
    # file=file_path+'CORDEX-EU_'+experiment+'_t2m_'+year+'.zip'
    
    # # Check if file exist to allow for easy redo
    # if os.path.isfile(file) == True:
        
    #     # Tell us the file exist
    #     print('NOTIFY: this file was allready done! '+file)
    
    # # if file doesn't exist, we download it
    # elif os.path.isfile(file) == False:
    #     c.retrieve(
    #         'projections-cordex-domains-single-levels',
    #         {
    #             'domain': 'europe',
    #             'experiment': experiment,
    #             'horizontal_resolution': '0_11_degree_x_0_11_degree',
    #             'temporal_resolution': '3_hours',
    #             'variable': '2m_air_temperature',
    #             'gcm_model': GCM_model,
    #             'rcm_model': RCM_model,
    #             'ensemble_member': ENSEMBLE_member,
    #             'start_year': year,
    #             'end_year': year,
    #             'format': 'zip',
    #         },
    #         file)
    
    # # Retrieve windspeed
    # file=file_path+'CORDEX-EU_'+experiment+'_wspd_'+year+'.zip'
    
    # # Check if file exist to allow for easy redo
    # if os.path.isfile(file) == True:
        
    #     # Tell us the file exist
    #     print('NOTIFY: this file was allready done! '+file)
    
    # # if file doesn't exist, we download it
    # elif os.path.isfile(file) == False:
    #     c.retrieve(
    #         'projections-cordex-domains-single-levels',
    #         {
    #             'domain': 'europe',
    #             'experiment': experiment,
    #             'horizontal_resolution': '0_11_degree_x_0_11_degree',
    #             'temporal_resolution': '3_hours',
    #             'variable': '10m_wind_speed',
    #             'gcm_model': GCM_model,
    #             'rcm_model': RCM_model,
    #             'ensemble_member': ENSEMBLE_member,
    #             'start_year': year,
    #             'end_year': year,
    #             'format': 'zip',
    #         },
    #         file)