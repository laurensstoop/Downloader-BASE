#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 18 11:25:08 2019

@author: Laurens Stoop - l.p.stoop@uu.nl
"""

"""
# Parameter names
t2m = 167.128
u10 = 165.128
v10 = 166.128
psl = 151.128
ssrd = 176.128 # Geeft issues - use fc not an

type; fc (forecast),  an (analysis)
"""


# =============================================================================
# Dependencies
# =============================================================================
from ecmwfapi import ECMWFDataServer
import numpy as np
import datetime as dt

# Set the server
server = ECMWFDataServer()

# define the storage location
file_path = '/media/DataDrive/ERAinterim/'

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



# Run over the years
for year in years:

    # Define the file name
    file = file_path+'ERAinterim-EU_'+year+'.nc'
    
    # Let's notify our terminal where we are!
    print(dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+' NOTIFY: Starting to retrieve '+file)



    ## The retrieval request
    server.retrieve({
        "expver": "1",
        "stream": "oper",
        "levtype": "sfc",
        "param": "176.128/165.128/166.128/167.128/151.128",
        "dataset": "interim",
        "step": "3/6/9/12",
        "grid": "0.75/0.75",
        "time": "00:00:00/12:00:00",
        "date": str(year)+'-01-01/to/'+str(year)+'-12-31',
        "area": "80/-31/34.5/74.25",
        "type": "fc",
        "class": "ei",
        "format": "netcdf",
        "target": file
    })

