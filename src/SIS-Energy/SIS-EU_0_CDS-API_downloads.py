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
file_path = '/media/DataFiles/SIS-EU_BASE/origin/'

#
#%%
# =============================================================================
# Download loop
# =============================================================================

# Make a shortcut for the CDS download client
c = cdsapi.Client(timeout=600,quiet=False,debug=True)


name_base=file_path+'SIS-EU_'

#%% Retrieve CNRM ALADIN

RCM='aladin63'
GCM='cnrm_cm5'
ENSM='r1i1p1'
rcps=['rcp_2_6', 'rcp_8_5']

#%%Retrieve EC-EARTH HIRHAM

# RCM='hirham5'
# GCM='ec_earth'
# ENSM='r3i1p1'
# rcps=['rcp_2_6', 'rcp_4_5', 'rcp_8_5'] 

#%% Retrieve hadgem RegCM 

# RCM='regcm4'
# GCM='hadgem2_es'
# ENSM='r1i1p1'
# rcps=['rcp_2_6', 'rcp_8_5'] 

#%%Retrieve NOR hirham

# RCM='hirham5'
# GCM='noresm1_m'
# ENSM='r1i1p1'
# rcps=['rcp_4_5', 'rcp_8_5'] 


#%%Retrieve  IPSL wrf

# RCM='wrf381p'
# GCM='ipsl_cm5a_mr'
# ENSM='r1i1p1'
# rcps=['rcp_4_5', 'rcp_8_5'] 

#%%Retrieve MPI CLM-community

# RCM='cclm4_8_17'
# GCM='mpi_esm_lr'
# ENSM='r1i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

#%%Retrieve EC-Earth RACMO

# RCM='racmo22e'
# GCM='ec_earth'
# ENSM='r1i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

#%%Retrieve HadGem RACMO

# RCM='racmo22e'
# GCM='hadgem2_es'
# ENSM='r1i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

#%%Retrieve EC-Earth RCA4

# RCM='rca4'
# GCM='ec_earth'
# ENSM='r12i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

#%%Retrieve hadgem RCA4

# RCM='rca4'
# GCM='hadgem2_es'
# ENSM='r1i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

#%%Retrieve MPI RCA4

# RCM='rca4'
# GCM='mpi_esm_lr'
# ENSM='r1i1p1'
# rcps=[ 'rcp_4_5', 'rcp_8_5'] 

# =============================================================================
# The rest of the loop
# =============================================================================
    
for RCP in rcps:
    file = name_base+GCM+'_'+RCM+'_'+RCP+'.zip'
    # Check if file exist to allow for easy redo
    if os.path.isfile(file) == True:
        
        # Tell us the file exist
        print('NOTIFY: this file was allready done! '+file)
    
    else: 
        c.retrieve(
            'sis-energy-derived-projections',
            {
                'format': 'zip',
                'variable': [
                    '2m_air_temperature', 'solar_photovoltaic_power_generation', 'surface_downwelling_shortwave_radiation',
                    'wind_power_generation_offshore', 'wind_power_generation_onshore', 'wind_speed_at_100m',
                    'wind_speed_at_10m',
                ],
                'spatial_aggregation': 'original_grid',
                'energy_product_type': 'capacity_factor_ratio',
                'temporal_aggregation': '3_hourly',
                'experiment': RCP,
                'rcm': RCM,
                'gcm': GCM,
                'ensemble_member': ENSM,
            },
            file)

