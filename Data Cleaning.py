import re
import pandas as pd
import numpy as np
import os
from pathlib import Path
import matplotlib.pyplot as plt

# Combining the csv's

file_path = "/Users/mryvi/Documents/Capstone/Election Results/csv"
#list all the files from the directory
file_list = os.listdir(file_path)
file_list

df_append = pd.DataFrame()
#append all files together
for file in file_list:
            data_folder = Path("/Users/mryvi/Documents/Capstone/Election Results/csv")
            df_temp = pd.read_csv(data_folder / file,dtype='str')
            df_append = df_append.append(df_temp, ignore_index=True)
Elections = df_append
Elections

Elections = Elections.drop('Unnamed: 7', axis=1)
Elections = Elections.drop('Unnamed: 8', axis=1)


# Make Numeric Values Floats

Elections = Elections.replace('^-$',np.nan,regex=True)
Elections['2014'] = [re.sub(',','',str(x)) for x in Elections['2014']]
Elections['2014'] = Elections['2014'].astype(float)
Elections['2019'] = [re.sub(',','',str(x)) for x in Elections['2019']]
Elections['2019'] = Elections['2019'].astype(float)
Elections


# Combine Groups Initially

## 2014

#Parliamentary Groups
Elections['2014 Parliamentary Group'] = [re.sub('ID\*|ID \?|ID','EFDD',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('EPP\*','EPP',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('ECR\*','ECR',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('GUE/NGL\*|Gue/NGL  ','GUE/NGL',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Renew Europe\*|ALDE\*','ALDE',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('S&D\*|S&D \?','S&D',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Greens/EFA\*|Greens/EFA \?|Green  \?|Green \?','Greens/EFA',str(x)) for x in Elections['2014 Parliamentary Group']]

#Ideologies
Elections['2014 Parliamentary Group'] = [re.sub('Right-Wing \?|NI - Right-Wing|Right-Wing\*|RIght-Wing \?|Far-Right\*|NI - Far-Right|Far-Right \?|Right Wing \?','Right-Wing/Far-Right',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Far-Left \?|Left-Wing \?|Far-Left\*|NI - Left-Wing|Far Left \?|NI - Far -Left|Left-Wing\*','Left-Wing/Far-Left',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Center\*|Center \?|Center \?|Liberal \?|Liberal\*','Center/Liberal',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Center-Right\*|Center-Right','Center-Right',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Center-Left\*|Center-Left \?','Center-Left',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('^NI$|^Unknown$|EFA \?','NI/Unknown',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Right \?|Right\*','Right?',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['2014 Parliamentary Group'] = [re.sub('Left \?|Left\*','Left?',str(x)) for x in Elections['2014 Parliamentary Group']]
Elections['x Parliamentary Group'].unique()

## 2019

#Parliamentary Groups
Elections['2019 Parliamentary Group'] = [re.sub('Renew Europe|ALDE\*|RE\*|ALDE','RE',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('RE\*','RE',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Greens/EFA\*|Greens/EFA \?|Green \?','Greens/EFA',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('EPP\*|EPP  ','EPP',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('ECR\*','ECR',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('ID\*','ID',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('GUE/NGL\*','GUE/NGL',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('S&D\*','S&D',str(x)) for x in Elections['2019 Parliamentary Group']]

#Ideologies
Elections['2019 Parliamentary Group'] = [re.sub('Left-Wing \?|Left-Wing\*$|Far-Left\*|Far-Left \?|Far-Left\*|Far Left \?|NI - Far -Left','Left-Wing/Far-Left',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Center\*|Liberal \?|Center \?','Center/Liberal',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Far Right\*|Right-Wing\*|Far-Right\*|Right-Wing \?|Far-Right \?|NI - Far-Right|NI - Right-Wing','Right-Wing/Far-Right',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Center-Right\*|Center-Right \?','Center-Right',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Center-Left\*|Center-Left \?','Center-Left',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('^NI$|^Unknown$|^EFA \?$|^NI - Regionalist$','NI/Unknown',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Left \?|Left\*','Left?',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'] = [re.sub('Right \?','Right?',str(x)) for x in Elections['2019 Parliamentary Group']]
Elections['2019 Parliamentary Group'].unique()

# Find Percentages for 2014 and 2019, drop other numeric columns

Elections['Total Votes 2014'] = Elections.assign(group=Elections['CODE:'].sum()).groupby('CODE:')['2014'].transform('sum')
Elections['Percent 2014'] = Elections['2014'] / Elections['Total Votes 2014']
Elections['Total Votes 2019'] = Elections.assign(group=Elections['CODE:'].sum()).groupby('CODE:')['2019'].transform('sum')
Elections['Percent 2019'] = Elections['2019'] / Elections['Total Votes 2019']
Elections = Elections.drop('2014', axis=1)
Elections = Elections.drop('Total Votes 2014', axis=1)
Elections = Elections.drop('2019', axis=1)
Elections = Elections.drop('Total Votes 2019', axis=1)

# Copy Data Set and Further Combine Groups

Elections2 = Elections.copy()

#2014
Elections2['2014 Parliamentary Group'] = [re.sub('Right-Wing/Far-Right|^ECR$|^EFDD$','ECR/EFDD',str(x)) for x in Elections2['2014 Parliamentary Group']]
Elections2['2014 Parliamentary Group'] = [re.sub('Center/Liberal','ALDE',str(x)) for x in Elections2['2014 Parliamentary Group']]
Elections2['2014 Parliamentary Group'] = [re.sub('Center-Right','EPP',str(x)) for x in Elections2['2014 Parliamentary Group']]
Elections2['2014 Parliamentary Group'] = [re.sub('Center-Left','S&D',str(x)) for x in Elections2['2014 Parliamentary Group']]
Elections2['2014 Parliamentary Group'] = [re.sub('Left-Wing/Far-Left','GUE/NGL',str(x)) for x in Elections2['2014 Parliamentary Group']]

Elections2['2014 Parliamentary Group'].unique()

#2019 
Elections2['2019 Parliamentary Group'] = [re.sub('Right-Wing/Far-Right|^ECR$|^ID$','ECR/ID',str(x)) for x in Elections2['2019 Parliamentary Group']]
Elections2['2019 Parliamentary Group'] = [re.sub('Center/Liberal','RE',str(x)) for x in Elections2['2019 Parliamentary Group']]
Elections2['2019 Parliamentary Group'] = [re.sub('Center-Right','EPP',str(x)) for x in Elections2['2019 Parliamentary Group']]
Elections2['2019 Parliamentary Group'] = [re.sub('Center-Left','S&D',str(x)) for x in Elections2['2019 Parliamentary Group']]
Elections2['2019 Parliamentary Group'] = [re.sub('Left-Wing/Far-Left','GUE/NGL',str(x)) for x in Elections2['2019 Parliamentary Group']]
Elections2['2019 Parliamentary Group'].unique()

# Separate into Columns

Elections3 = Elections2.copy()

#2014
Elections3['ECR/EFDD 2014'] = Elections3['Percent 2014'].where((Elections3['2014 Parliamentary Group'] == "ECR/EFDD")|(Elections3['Party'] =="LA DROITE")|(Elections3['Party'] =="Alliance for Croatia")|(Elections3['Party'] =="Union Populaire Républicaine (UPR)")|(Elections3['Party'] =="Christian Slovak National Party")|(Elections3['Party'] =="Individual Freedom Party (P–LIB)"))
Elections3['EPP 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "EPP")
Elections3['ALDE 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "ALDE")
Elections3['Greens/EFA 2014'] = Elections3['Percent 2014'].where((Elections3['2014 Parliamentary Group'] == "Greens/EFA")|(Elections3['Party'] == "Europe Citoyenne (EC)"))
Elections3['S&D 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "S&D")
Elections3['GUE/NGL 2014'] = Elections3['Percent 2014'].where((Elections3['2014 Parliamentary Group'] == "GUE/NGL")|(Elections3['Party'] == "National Health Action Party")|(Elections3['Party'] == "PH - PARTIDO HUMANISTA"))
Elections3['NI/Unknown 2014'] = Elections3['Percent 2014'].where((Elections3['2014 Parliamentary Group'] == "NI/Unknown")|(Elections3['Party'] == "Cannabis sans Frontières (CSF)"))
Elections3['Animal 2014'] = Elections3['Percent 2014'].where(((Elections3['Party'] == "Animals' Party")&(Elections3['CODE:'] == "SE"))|((Elections3['Party'] == "Animal Welfare Party")&(Elections3['CODE:'] == "UK")))
Elections3['S&D OR GUE/NGL 2014'] = Elections3['Percent 2014'].where((Elections3['Party'] == "I.Fem - INICIATIVA FEMINISTA")|(Elections3['Party'] == "Féministes pour une Europe solidaire (FPES)"))
Elections3['EPP & ECR 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "EPP & ECR")
Elections3['S&D & ALDE 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "S&D & ALDE")
Elections3['GUE/NGL & Greens/EFA 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "GUE/NGL & Greens/EFA")
Elections3['ALDE & EPP 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == "ALDE & EPP")

#2019
Elections3['ECR/ID 2019'] = Elections3['Percent 2019'].where((Elections3['2019 Parliamentary Group'] == "ECR/ID")|(Elections3['Party'] =="Bündnis C"))
Elections3['EPP 2019'] = Elections3['Percent 2019'].where((Elections3['2019 Parliamentary Group'] == "EPP")|(Elections3['Party'] =="Slovak Conservative Party"))
Elections3['RE 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "RE")
Elections3['Greens/EFA 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "Greens/EFA")
Elections3['S&D 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "S&D")
Elections3['GUE/NGL 2019'] = Elections3['Percent 2019'].where((Elections3['2019 Parliamentary Group'] == "GUE/NGL")|((Elections3['Party'] == "Feminist Party")&(Elections3['CODE:'] == "FI"))|(Elections3['Party'] == "PH - PARTIDO HUMANISTA"))
Elections3['NI/Unknown 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "NI/Unknown")
Elections3['Right? 2019'] = Elections3['Percent 2019'].where((Elections3['Party'] =="We Social Conservatives"))
Elections3['S&D OR GUE/NGL 2019'] = Elections3['Percent 2019'].where((Elections3['Party'] == "UNE EUROPE AU SERVICE DES PEUPLES")|(Elections3['Party'] == "Die Humanisten")|(Elections3['Party'] == "DIE FRAUEN")|(Elections3['Party'] == "BGE")|(Elections3['Party'] == "Tolerance and Coexistence Party")|(Elections3['Party'] == "I.Fem - INICIATIVA FEMINISTA")|((Elections3['Party'] == "Women's Equality Party")&(Elections3['CODE:'] == "UK")))
Elections3['Animal 2019'] = Elections3['Percent 2019'].where(((Elections3['Party'] == "Animal Justice Party")&(Elections3['CODE:'] == "FI"))|((Elections3['Party'] == "Animals' Party")&(Elections3['CODE:'] == "SE"))|((Elections3['Party'] == "Animal Welfare Party")&(Elections3['CODE:'] == "UK")))
Elections3['RE & Greens/EFA 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "RE & Greens/EFA")
Elections3['Greens/EFA & NI 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "Greens/EFA & NI")
Elections3['Left-Wing & Pirate 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "Left-Wing* & Pirate*")
Elections3['EPP & ECR 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "EPP & ECR")
Elections3['EPP & S&D 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "EPP & S&D")
Elections3['EPP & RE 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "EPP & RE")
Elections3['GUE/NGL & Greens/EFA 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "GUE/NGL & Greens/EFA")
Elections3['GUE/NGL & Greens/EFA & NI 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == "GUE/NGL & Greens/EFA & NI")

Elections3

# Combine by Country

Elections4 = Elections3.copy()
Elections4 = Elections4.groupby(['CODE:','COUNTRY:']).sum()
Elections4 = Elections4.drop('Percent 2014', axis=1)
Elections4 = Elections4.drop('Percent 2019', axis=1)
Elections4['Total'] = Elections4.sum(axis=1)
Elections4

# Removing Extra Columns by Adding them to Others

Elections5 = Elections4.copy()

#2014

Elections5['EPP 2014'] = Elections5['EPP 2014'] + (5/6)*Elections5['EPP & ECR 2014']
Elections5['ECR/EFDD 2014'] = Elections5['ECR/EFDD 2014'] + (1/6)*Elections5['EPP & ECR 2014']
Elections5 = Elections5.drop('EPP & ECR 2014', axis=1)

Elections5['S&D 2014'] = Elections5['S&D 2014'] + (1/2)*Elections5['S&D & ALDE 2014']
Elections5['ALDE 2014'] = Elections5['ALDE 2014'] + (1/2)*Elections5['S&D & ALDE 2014']
Elections5 = Elections5.drop('S&D & ALDE 2014', axis=1)

Elections5['GUE/NGL 2014'] = Elections5['GUE/NGL 2014'] + (5/6)*Elections5['GUE/NGL & Greens/EFA 2014']
Elections5['Greens/EFA 2014'] = Elections5['Greens/EFA 2014'] + (1/6)*Elections5['GUE/NGL & Greens/EFA 2014']
Elections5 = Elections5.drop('GUE/NGL & Greens/EFA 2014', axis=1)

Elections5['ALDE 2014'] = Elections5['ALDE 2014'] + (2/3)*Elections5['ALDE & EPP 2014']
Elections5['EPP 2014'] = Elections5['EPP 2014'] + (1/3)*Elections5['ALDE & EPP 2014']
Elections5 = Elections5.drop('ALDE & EPP 2014', axis=1)

Elections5['Greens/EFA 2014'] = Elections5['Greens/EFA 2014'] + (1/2)*Elections5['Animal 2014']
Elections5['GUE/NGL 2014'] = Elections5['GUE/NGL 2014'] + (1/2)*Elections5['Animal 2014']
Elections5 = Elections5.drop('Animal 2014', axis=1)

Elections5['S&D 2014'] = Elections5['S&D 2014'] + (1/2)*Elections5['S&D OR GUE/NGL 2014']
Elections5['GUE/NGL 2014'] = Elections5['GUE/NGL 2014'] + (1/2)*Elections5['S&D OR GUE/NGL 2014']
Elections5 = Elections5.drop('S&D OR GUE/NGL 2014', axis=1)

#2019

Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + Elections5['RE & Greens/EFA 2019']
Elections5 = Elections5.drop('RE & Greens/EFA 2019', axis=1)

Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + (1/2)*Elections5['Greens/EFA & NI 2019']
Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (1/2)*Elections5['Greens/EFA & NI 2019']
Elections5 = Elections5.drop('Greens/EFA & NI 2019', axis=1)

Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + (1/2)*Elections5['Left-Wing & Pirate 2019']
Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (1/2)*Elections5['Left-Wing & Pirate 2019']
Elections5 = Elections5.drop('Left-Wing & Pirate 2019', axis=1)

Elections5['EPP 2019'] = Elections5['EPP 2019'] + (1/2)*Elections5['EPP & ECR 2019']
Elections5['ECR/ID 2019'] = Elections5['ECR/ID 2019'] + (1/2)*Elections5['EPP & ECR 2019']
Elections5 = Elections5.drop('EPP & ECR 2019', axis=1)

Elections5['EPP 2019'] = Elections5['EPP 2019'] + (17/22)*Elections5['EPP & S&D 2019']
Elections5['S&D 2019'] = Elections5['S&D 2019'] + (5/22)*Elections5['EPP & S&D 2019']
Elections5 = Elections5.drop('EPP & S&D 2019', axis=1)

Elections5['EPP 2019'] = Elections5['EPP 2019'] + (1/2)*Elections5['EPP & RE 2019']
Elections5['RE 2019'] = Elections5['RE 2019'] + (1/2)*Elections5['EPP & RE 2019']
Elections5 = Elections5.drop('EPP & RE 2019', axis=1)

Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (5/6)*Elections5['GUE/NGL & Greens/EFA 2019']
Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + (1/6)*Elections5['GUE/NGL & Greens/EFA 2019']
Elections5 = Elections5.drop('GUE/NGL & Greens/EFA 2019', axis=1)

Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (1/3)*Elections5['GUE/NGL & Greens/EFA & NI 2019']
Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + (2/3)*Elections5['GUE/NGL & Greens/EFA & NI 2019']
Elections5 = Elections5.drop('GUE/NGL & Greens/EFA & NI 2019', axis=1)

Elections5['EPP 2019'] = Elections5['EPP 2019'] + (1/3)*Elections5['Right? 2019']
Elections5['ECR/ID 2019'] = Elections5['ECR/ID 2019'] + (2/3)*Elections5['Right? 2019']
Elections5 = Elections5.drop('Right? 2019', axis=1)

Elections5['Greens/EFA 2019'] = Elections5['Greens/EFA 2019'] + (1/2)*Elections5['Animal 2019']
Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (1/2)*Elections5['Animal 2019']
Elections5 = Elections5.drop('Animal 2019', axis=1)

Elections5['S&D 2019'] = Elections5['S&D 2019'] + (1/2)*Elections5['S&D OR GUE/NGL 2019']
Elections5['GUE/NGL 2019'] = Elections5['GUE/NGL 2019'] + (1/2)*Elections5['S&D OR GUE/NGL 2019']
Elections5 = Elections5.drop('S&D OR GUE/NGL 2019', axis=1)

Elections5.to_csv("/Users/mryvi/Documents/Capstone/FinalElections.csv")

# Other Data

data = pd.read_csv('/Users/mryvi/Documents/Capstone/Data(One Sheet).csv',dtype='str')

for col in data.iloc[:,2:].columns:
    data[col] = [re.sub('%','',str(x)) for x in data[col]]
    data[col] = [re.sub(',','',str(x)) for x in data[col]]
    data[col] = [re.sub('\$','',str(x)) for x in data[col]]
    data[col] = [re.sub(':','999999999999999',str(x)) for x in data[col]]
    data[col] = data[col].astype(float)
    data[col] = data[col].replace(999999999999999,np.nan)

for col in data.iloc[:,6:72].columns:
    data[col] = data[col] / 100
    
for col in data.iloc[:,89:].columns:
    data[col] = data[col] / 100
    
data = data.drop([0])
data

# Finding Percent Changes

data['GDP (PPP) Percent Change 2013-2014'] = (data['2014 GDP (PPP) International Dollars'] - data['2013 GDP (PPP) International Dollars'])/data['2013 GDP (PPP) International Dollars']
data['GDP (PPP) Percent Change 2018-2019'] = (data['2019 GDP (PPP) International Dollars'] - data['2018 GDP (PPP) International Dollars'])/data['2018 GDP (PPP) International Dollars']
data['Total Immigration Change 2018-2019'] = (data['2019: Total Immigration'] - data['2018: Total Immigration'])/data['2018: Total Immigration']
data['EU27 Immigration Change 2018-2019'] = (data['2019: EU27 Immigration'] - data['2018: EU27 Immigration'])/data['2018: EU27 Immigration']
data['Non-EU27 Immigration Change 2018-2019'] = (data['2019: Non-EU27 Immigration'] - data['2018: Non-EU27 Immigration'])/data['2018: Non-EU27 Immigration']
data['Unknown Immigration Change 2018-2019'] = (data['2019: Unknown Immigration'] - data['2018: Non-EU27 Immigration'])/data['2018: Unknown Immigration']
data['Total Immigration Change 2013-2014'] = (data['2014: Total Immigration'] - data['2013: Total Immigration'])/data['2013: Total Immigration']
data['EU27 Immigration Change 2013-2014'] = (data['2014: EU27 Immigration'] - data['2013: EU27 Immigration'])/data['2013: EU27 Immigration']
data['Non-EU27 Immigration Change 2013-2014'] = (data['2014: Non-EU27 Immigration'] - data['2013: Non-EU27 Immigration'])/data['2013: Non-EU27 Immigration']
data['Unknown Immigration Change 2013-2014'] = (data['2014: Unknown Immigration'] - data['2013: Non-EU27 Immigration'])/data['2013: Unknown Immigration']
data = data.replace(-np.inf, np.nan)

## Combine Both Datasets

CombinedData = Elections5.merge(data, on=['COUNTRY:','CODE:'])
CombinedData

CombinedData.to_csv("/Users/mryvi/Documents/Capstone/AllData.csv")

## Separate Into Two Datasets

Columns2014 = list() 
Columns2014.append('CODE:')
Columns2014.append('COUNTRY:')

for col in CombinedData.columns:
    if re.search('2014',col) or re.search('2013',col):
        Columns2014.append(col)

Columns2019 = list() 
Columns2019.append('CODE:')
Columns2019.append('COUNTRY:')

for col in CombinedData.columns:
    if re.search('2019',col) or re.search('2018',col):
        Columns2019.append(col)
      
Data2014 = CombinedData.copy()
for col in Data2014.columns:
    if col not in Columns2014:
        Data2014 = Data2014.drop(col,axis=1)
Data2014.to_csv("/Users/mryvi/Documents/Capstone/2014Data.csv")

Data2019 = CombinedData.copy()
for col in Data2019.columns:
    if col not in Columns2019:
        Data2019 = Data2019.drop(col,axis=1)
Data2019Redo = Data2019.copy()
Data2019Redo = Data2019Redo.rename(columns=lambda x: re.sub('2018','2013',x))
Data2019Redo = Data2019Redo.rename(columns=lambda x: re.sub('2019','2014',x))
Data2019Redo = Data2019Redo.rename(columns=lambda x: re.sub('^RE 2014$','ALDE 2014',x))
Data2019Redo = Data2019Redo.rename(columns=lambda x: re.sub('^ECR/ID 2014$','ECR/EFDD 2014',x))
Data2019Redo = Data2019Redo.rename(columns=lambda x: re.sub('Not satisfied with Life','Not Satisfied with Life',x))
Data2019Redo.to_csv("/Users/mryvi/Documents/Capstone/2019Data.csv")
