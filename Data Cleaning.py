import re
import pandas as pd
import numpy as np
import os
from pathlib import Path
import matplotlib.pyplot as plt

#############################################################################################################################
##### Combining the Election Result CSV's
#############################################################################################################################

# Define the file path
file_path = ""

# List all the files from the directory
file_list = os.listdir(file_path)

# Initialize an empty DataFrame
df_append = pd.DataFrame()

# Append all files together
for file in file_list:
    data_folder = Path(file_path)
    df_temp = pd.read_csv(data_folder / file, dtype='str')
    df_append = df_append.append(df_temp, ignore_index=True)

# Assign the appended DataFrame to 'Elections'
Elections = df_append

# Drop unnecessary columns
Elections = Elections.drop(['Unnamed: 7', 'Unnamed: 8'], axis=1)

#############################################################################################################################
##### Make Numeric Values Floats
#############################################################################################################################

# Replace '-' with NaN
Elections = Elections.replace('^-$', np.nan, regex=True)

# Clean and convert '2014' and '2019' columns
Elections['2014'] = Elections['2014'].replace(',', '', regex=True).astype(float)
Elections['2019'] = Elections['2019'].replace(',', '', regex=True).astype(float)

#############################################################################################################################
##### Combine Groups Initially
#############################################################################################################################

### 2014
#############################################

# Define the replacements for Parliamentary Groups
parliamentary_groups = {
    'ID\*|ID \?|ID': 'EFDD',
    'EPP\*': 'EPP',
    'ECR\*': 'ECR',
    'GUE/NGL\*|Gue/NGL  ': 'GUE/NGL',
    'Renew Europe\*|ALDE\*': 'ALDE',
    'S&D\*|S&D \?': 'S&D',
    'Greens/EFA\*|Greens/EFA \?|Green  \?|Green \?': 'Greens/EFA'
}

# Define the replacements for Ideologies
ideologies = {
    'Right-Wing \?|NI - Right-Wing|Right-Wing\*|RIght-Wing \?|Far-Right\*|NI - Far-Right|Far-Right \?|Right Wing \?': 'Right-Wing/Far-Right',
    'Far-Left \?|Left-Wing \?|Far-Left\*|NI - Left-Wing|Far Left \?|NI - Far -Left|Left-Wing\*': 'Left-Wing/Far-Left',
    'Center\*|Center \?|Center \?|Liberal \?|Liberal\*': 'Center/Liberal',
    'Center-Right\*|Center-Right': 'Center-Right',
    'Center-Left\*|Center-Left \?': 'Center-Left',
    '^NI$|^Unknown$|EFA \?': 'NI/Unknown',
    'Right \?|Right\*': 'Right?',
    'Left \?|Left\*': 'Left?'
}

# Combine the two dictionaries
replacements = {**parliamentary_groups, **ideologies}

# Apply the replacements for Parliamentary Groups and Ideologies
for old, new in replacements.items():
    Elections['2014 Parliamentary Group'] = Elections['2014 Parliamentary Group'].replace(old, new, regex=True)

### 2019
#############################################

# Define the replacements for Parliamentary Groups
parliamentary_groups = {
    'Renew Europe|ALDE\*|RE\*|ALDE': 'RE',
    'RE\*': 'RE',
    'Greens/EFA\*|Greens/EFA \?|Green \?': 'Greens/EFA',
    'EPP\*|EPP  ': 'EPP',
    'ECR\*': 'ECR',
    'ID\*': 'ID',
    'GUE/NGL\*': 'GUE/NGL',
    'S&D\*': 'S&D'
}

# Define the replacements for Ideologies
ideologies = {
    'Left-Wing \?|Left-Wing\*$|Far-Left\*|Far-Left \?|Far-Left\*|Far Left \?|NI - Far -Left': 'Left-Wing/Far-Left',
    'Center\*|Liberal \?|Center \?': 'Center/Liberal',
    'Far Right\*|Right-Wing\*|Far-Right\*|Right-Wing \?|Far-Right \?|NI - Far-Right|NI - Right-Wing': 'Right-Wing/Far-Right',
    'Center-Right\*|Center-Right \?': 'Center-Right',
    'Center-Left\*|Center-Left \?': 'Center-Left',
    '^NI$|^Unknown$|^EFA \?$|^NI - Regionalist$': 'NI/Unknown',
    'Left \?|Left\*': 'Left?',
    'Right \?': 'Right?'
}

# Combine the two dictionaries
replacements = {**parliamentary_groups, **ideologies}

# Apply the replacements for Parliamentary Groups and Ideologies
for old, new in replacements.items():
    Elections['2019 Parliamentary Group'] = Elections['2019 Parliamentary Group'].replace(old, new, regex=True)

#############################################################################################################################
##### Find Percentages for 2014 and 2019, drop other numeric columns
#############################################################################################################################

# Calculate total votes and percentages for 2014 and 2019
for year in ['2014', '2019']:
    total_votes = Elections.assign(group=Elections['CODE:'].sum()).groupby('CODE:')[year].transform('sum')
    Elections[f'Total Votes {year}'] = total_votes
    Elections[f'Percent {year}'] = Elections[year] / total_votes

# Drop unnecessary columns
Elections = Elections.drop(['2014', 'Total Votes 2014', '2019', 'Total Votes 2019'], axis=1)

#############################################################################################################################
##### Copy Data Set and Further Combine Groups
#############################################################################################################################

Elections2 = Elections.copy()

# Define the replacements for Parliamentary Groups for 2014 and 2019
replacements_2014 = {
    'Right-Wing/Far-Right|^ECR$|^EFDD$': 'ECR/EFDD',
    'Center/Liberal': 'ALDE',
    'Center-Right': 'EPP',
    'Center-Left': 'S&D',
    'Left-Wing/Far-Left': 'GUE/NGL'
}

replacements_2019 = {
    'Right-Wing/Far-Right|^ECR$|^ID$': 'ECR/ID',
    'Center/Liberal': 'RE',
    'Center-Right': 'EPP',
    'Center-Left': 'S&D',
    'Left-Wing/Far-Left': 'GUE/NGL'
}

# Apply the replacements for Parliamentary Groups for 2014 and 2019
for old, new in replacements_2014.items():
    Elections2['2014 Parliamentary Group'] = Elections2['2014 Parliamentary Group'].replace(old, new, regex=True)

for old, new in replacements_2019.items():
    Elections2['2019 Parliamentary Group'] = Elections2['2019 Parliamentary Group'].replace(old, new, regex=True)

#############################################################################################################################
##### Separate into Columns
#############################################################################################################################

Elections3 = Elections2.copy()

### 2014
#############################################

# Define the replacements for 2014
replacements_2014 = {
    'ECR/EFDD': ['ECR/EFDD', 'LA DROITE', 'Alliance for Croatia', 'Union Populaire Républicaine (UPR)', 'Christian Slovak National Party', 'Individual Freedom Party (P–LIB)'],
    'EPP': ['EPP'],
    'ALDE': ['ALDE'],
    'Greens/EFA': ['Greens/EFA', 'Europe Citoyenne (EC)'],
    'S&D': ['S&D'],
    'GUE/NGL': ['GUE/NGL', 'National Health Action Party', 'PH - PARTIDO HUMANISTA'],
    'NI/Unknown': ['NI/Unknown', 'Cannabis sans Frontières (CSF)'],
    'Animal': ['Animals\' Party', 'Animal Welfare Party'],
    'S&D OR GUE/NGL': ['I.Fem - INICIATIVA FEMINISTA', 'Féministes pour une Europe solidaire (FPES)'],
    'EPP & ECR': ['EPP & ECR'],
    'S&D & ALDE': ['S&D & ALDE'],
    'GUE/NGL & Greens/EFA': ['GUE/NGL & Greens/EFA'],
    'ALDE & EPP': ['ALDE & EPP']
}

# Apply the replacements for 2014
for new, old_list in replacements_2014.items():
    for old in old_list:
        Elections3[f'{new} 2014'] = Elections3['Percent 2014'].where(Elections3['2014 Parliamentary Group'] == old)


### 2019
#############################################

# Define the replacements for 2019
replacements_2019 = {
    'ECR/ID': ['ECR/ID', 'Bündnis C'],
    'EPP': ['EPP', 'Slovak Conservative Party'],
    'RE': ['RE'],
    'Greens/EFA': ['Greens/EFA'],
    'S&D': ['S&D'],
    'GUE/NGL': ['GUE/NGL', 'Feminist Party', 'PH - PARTIDO HUMANISTA'],
    'NI/Unknown': ['NI/Unknown'],
    'Right?': ['We Social Conservatives'],
    'S&D OR GUE/NGL': ['UNE EUROPE AU SERVICE DES PEUPLES', 'Die Humanisten', 'DIE FRAUEN', 'BGE', 'Tolerance and Coexistence Party', 'I.Fem - INICIATIVA FEMINISTA', 'Women\'s Equality Party'],
    'Animal': ['Animal Justice Party', 'Animals\' Party', 'Animal Welfare Party'],
    'RE & Greens/EFA': ['RE & Greens/EFA'],
    'Greens/EFA & NI': ['Greens/EFA & NI'],
    'Left-Wing & Pirate': ['Left-Wing* & Pirate*'],
    'EPP & ECR': ['EPP & ECR'],
    'EPP & S&D': ['EPP & S&D'],
    'EPP & RE': ['EPP & RE'],
    'GUE/NGL & Greens/EFA': ['GUE/NGL & Greens/EFA'],
    'GUE/NGL & Greens/EFA & NI': ['GUE/NGL & Greens/EFA & NI']
}

# Apply the replacements for 2019
for new, old_list in replacements_2019.items():
    for old in old_list:
        Elections3[f'{new} 2019'] = Elections3['Percent 2019'].where(Elections3['2019 Parliamentary Group'] == old)

#############################################################################################################################
##### Combine by Country
#############################################################################################################################

Elections4 = Elections3.copy()

# Group by 'CODE:' and 'COUNTRY:' and sum the values
Elections4 = Elections4.groupby(['CODE:', 'COUNTRY:']).sum()

# Drop unnecessary columns
Elections4 = Elections4.drop(['Percent 2014', 'Percent 2019'], axis=1)

# Calculate the total
Elections4['Total'] = Elections4.sum(axis=1)

#############################################################################################################################
##### Split up mixed parties into specific parties based on number of seats by member
#############################################################################################################################

Elections5 = Elections4.copy()

### 2014
#############################################

# Define the replacements for 2014
replacements_2014 = {
    'EPP & ECR': ('EPP 2014', 'ECR/EFDD 2014', 5/6, 1/6),
    'S&D & ALDE': ('S&D 2014', 'ALDE 2014', 1/2, 1/2),
    'GUE/NGL & Greens/EFA': ('GUE/NGL 2014', 'Greens/EFA 2014', 5/6, 1/6),
    'ALDE & EPP': ('ALDE 2014', 'EPP 2014', 2/3, 1/3),
    'Animal': ('Greens/EFA 2014', 'GUE/NGL 2014', 1/2, 1/2),
    'S&D OR GUE/NGL': ('S&D 2014', 'GUE/NGL 2014', 1/2, 1/2)
}

# Apply the replacements for 2014
for old, (new1, new2, ratio1, ratio2) in replacements_2014.items():
    Elections5[new1] = Elections5[new1] + ratio1 * Elections5[old]
    Elections5[new2] = Elections5[new2] + ratio2 * Elections5[old]
    Elections5 = Elections5.drop(old, axis=1)

### 2019
#############################################

# Define the replacements for 2019
replacements_2019 = {
    'RE & Greens/EFA': ('Greens/EFA 2019', None, 1, 0),
    'Greens/EFA & NI': ('Greens/EFA 2019', 'GUE/NGL 2019', 1/2, 1/2),
    'Left-Wing & Pirate': ('Greens/EFA 2019', 'GUE/NGL 2019', 1/2, 1/2),
    'EPP & ECR': ('EPP 2019', 'ECR/ID 2019', 1/2, 1/2),
    'EPP & S&D': ('EPP 2019', 'S&D 2019', 17/22, 5/22),
    'EPP & RE': ('EPP 2019', 'RE 2019', 1/2, 1/2),
    'GUE/NGL & Greens/EFA': ('GUE/NGL 2019', 'Greens/EFA 2019', 5/6, 1/6),
    'GUE/NGL & Greens/EFA & NI': ('GUE/NGL 2019', 'Greens/EFA 2019', 1/3, 2/3),
    'Right?': ('EPP 2019', 'ECR/ID 2019', 1/3, 2/3),
    'Animal': ('Greens/EFA 2019', 'GUE/NGL 2019', 1/2, 1/2),
    'S&D OR GUE/NGL': ('S&D 2019', 'GUE/NGL 2019', 1/2, 1/2)
}

# Apply the replacements for 2019
for old, (new1, new2, ratio1, ratio2) in replacements_2019.items():
    Elections5[new1] = Elections5[new1] + ratio1 * Elections5[old]
    if new2:
        Elections5[new2] = Elections5[new2] + ratio2 * Elections5[old]
    Elections5 = Elections5.drop(old, axis=1)

# Save to csv
Elections5.to_csv()

#############################################################################################################################
##### Dependent Variables
#############################################################################################################################

# Load the data
data = pd.read_csv()

# Define the replacements
replacements = {
    '%': '',
    ',': '',
    '$': '',
    ':': 'NaN'
}

# Apply the replacements and convert to float
for col in data.iloc[:, 2:].columns:
    for old, new in replacements.items():
        data[col] = data[col].str.replace(old, new)
    data[col] = data[col].astype(float)

# Convert percentages to fractions
for col in data.iloc[:, 6:72].columns.union(data.iloc[:, 89:].columns):
    data[col] = data[col] / 100

# Drop the first row
data = data.drop([0])

### Finding Percent Changes
#############################################

# Define the changes to calculate
changes = {
    'GDP (PPP)': ['2013-2014', '2018-2019'],
    'Total Immigration': ['2013-2014', '2018-2019'],
    'EU27 Immigration': ['2013-2014', '2018-2019'],
    'Non-EU27 Immigration': ['2013-2014', '2018-2019'],
    'Unknown Immigration': ['2013-2014', '2018-2019']
}

# Calculate the changes
for change, years in changes.items():
    for year in years:
        start_year, end_year = year.split('-')
        data[f'{change} Percent Change {year}'] = (data[f'{end_year}: {change}'] - data[f'{start_year}: {change}']) / data[f'{start_year}: {change}']

# Replace -inf with NaN
data = data.replace(-np.inf, np.nan)

#############################################################################################################################
##### Combine Both Datasets
#############################################################################################################################

# Merge the dataframes
CombinedData = Elections5.merge(data, on=['COUNTRY:', 'CODE:'])
CombinedData.to_csv()

# Define the columns for 2014 and 2019 datasets
Columns2014 = [col for col in CombinedData.columns if '2014' in col or '2013' in col or col in ['CODE:', 'COUNTRY:']]
Columns2019 = [col for col in CombinedData.columns if '2019' in col or '2018' in col or col in ['CODE:', 'COUNTRY:']]

# Create 2014 dataset
Data2014 = CombinedData[Columns2014].copy()
Data2014.to_csv("/Users/mryvi/Documents/Capstone/2014Data.csv")

# Create 2019 dataset
Data2019 = CombinedData[Columns2019].copy()
Data2019Redo = Data2019.copy()

# Rename columns
Data2019Redo.columns = Data2019Redo.columns.str.replace('2018', '2013')
Data2019Redo.columns = Data2019Redo.columns.str.replace('2019', '2014')
Data2019Redo.columns = Data2019Redo.columns.str.replace('^RE 2014$', 'ALDE 2014')
Data2019Redo.columns = Data2019Redo.columns.str.replace('^ECR/ID 2014$', 'ECR/EFDD 2014')
Data2019Redo.columns = Data2019Redo.columns.str.replace('Not satisfied with Life', 'Not Satisfied with Life')

Data2019Redo.to_csv()
