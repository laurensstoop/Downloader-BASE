#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 09:26:04 2022

@author: stoop
"""

# Get the dependencies
import xarray as xr
import numpy as np
import datetime as dt
import os.path

# define the storage location
file_path = '/media/DataStager1/CERRA-Forecast/origin/'


ds = xr.open_dataset(file_path+'CERRA-Forecast_202101.grib', engine='cfgrib', decode_cf=True)
ds.load()

