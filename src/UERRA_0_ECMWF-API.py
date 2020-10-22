#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 24 18:40:17 2019

@author: Laurens Stoop - l.p.stoop@uu.nl
"""
import calendar
import datetime as dt
import numpy as np
import os.path

from ecmwfapi import ECMWFDataServer
server = ECMWFDataServer()

# Based on example code of ECWMF
#variables = [
#        "207", 
#        "167", 
#        "169"
#        ]

var = "167/169/207"

# define the variables to run over (short name)
#variable_names = [
#        'wspd',
#        't2m',
#        'ssrd'
#        ]


# SETUP [done: UM-fc, Harm-an, ]
gcm='COSMO' # option = Harmonie (eswi), UM (egrr), Cosmo (edzw)                           TODO:  UM/en (EGRR), Mescan-Surfex (lfpw) 
gcm_code='edzw'
type_of_model='enda' # option= oper/enda

# define the storage location
file_path = '/media/DataFiles/UERRA/origin/'+gcm+'/'

def retrieve_uerra_eswi():
    """
       A function to demonstrate how to iterate efficiently over several years and months etc
       for a particular UERRA request for origin SMHI.
       Change the variables below to adapt the iteration to your needs.
       You can use the variable 'target' to organise the requested data in files as you wish.
       In the example below the data are organised in files per month. (eg "uerra_eswi_daily_201510.grb")
    """
    YEAR=2010
    
#    yearStart = 2006 #1961
#    yearEnd = 2010 #2018
    monthStart = 1
    monthEnd = 12 #12
    for year in list(range(YEAR, YEAR + 1)):
        for month in list(range(monthStart, monthEnd + 1)):
                
                    
            # Run over 5 numbers to get the data we want
            for model in np.arange(21):
        
                # Define the variable name we want to work with
                model_name = 'M'+str(model).zfill(2)
                startDate = '%04d%02d%02d' % (year, month, 1)
                numberOfDays = calendar.monthrange(year, month)[1]
                lastDate = '%04d%02d%02d' % (year, month, numberOfDays)
                target = file_path+model_name+"/UERRA-EU_"+gcm+'-'+type_of_model+'_'+model_name+"_%04d-%02d.grib" % (year, month)
                requestDates = (startDate + "/TO/" + lastDate)
    
                # Check if file exist to allow for easy redo
                if os.path.isfile(target) == True:
                    
                    # Tell us the file exist
                    print('NOTIFY: this file was allready done! '+target)
        
                    
                # if file doesn't exist, we download it
                elif os.path.isfile(target) == False:
                    
                    # Let's notify our terminal where we are!
                    print(dt.datetime.now().strftime('%Y-%m-%d %H:%M')+' NOTIFY: Starting to retrieve '+target)
            
                    # download based on preset
                    uerra_eswi_request(requestDates, target, var, model)
                        
         

def uerra_eswi_request(requestDates, target, var, model):
    """
        A UERRA request for origin SMHI, for analysis pressure level data.
        Change the keywords below to adapt it to your needs.
        (eg to add or to remove  levels, parameters, times etc)
        Request cost per day is XXXX fields, XXXX Mbytes
    """
    server.retrieve({
        "class": "ur", 
        "dataset": "uerra",
        "date": requestDates,
        "expver": "prod",
        "levtype": "sfc",
        "origin": gcm_code, # eswi is Harmonie / egrr is UM
        "param": var, 
        "number": str(model),  #"0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20",
        "step": "1/2/3/4/5/6",
        "stream": type_of_model, # enda for COSMO, oper for Harmonie, UM
        "time": "00/06/12/18",
        "type": 'fc', 
        "target": target
        })
        

if __name__ == '__main__':
    retrieve_uerra_eswi()