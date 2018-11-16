
# Data Cleaning for Accural Model

import pandas as pd 
import numpy as np

comp = pd.read_csv("compustat_1950_2018_annual_merged.csv")

comp1 = comp[["gvkey","datadate","fyear","revt","rect","ppegt","epspi","ni","at","oancf","sic","rdq"]]
comp2 = comp1[comp1['gvkey'] == 1602]
comp3 = comp2[comp2['fyear'] > 1980]
comp3 = comp3[comp3['fyear'] < 2018]
comp4 = comp3[comp3['rect'] > 0]
comp5 = comp4.dropna(subset = ['at','revt','ni','epspi','rect','oancf'])
comp6 = comp5.drop_duplicates(comp5.columns.difference(['rdq']))
com_7 = comp6.fillna(0)

com_7.to_csv('amgen_compustate.csv', float_format = '%.6f', index = 0)


############################################################################

comp = pd.read_csv("compustat_1950_2018_annual_merged.csv")

comp1 = comp[["gvkey",'conm',"datadate","fyear","revt","rect","ppegt","epspi","ni","at","oancf","sic","rdq"]]
comp2 = comp1[comp1['sic'] == 2836]
comp3 = comp2[comp2['fyear'] > 1980]
comp3 = comp3[comp3['fyear'] < 2018]
comp4 = comp3[comp3['rect'] > 0]
comp5 = comp4.dropna(subset = ['at','revt','ni','epspi','rect','oancf'])
comp6 = comp5.drop_duplicates(comp5.columns.difference(['rdq']))
com_7 = comp6.fillna(0)

com_7.to_csv('amgen_compustate_2386.csv', float_format = '%.6f', index = 0)


