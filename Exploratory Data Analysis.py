import re
import pandas as pd
import numpy as np
import os
from pathlib import Path
import matplotlib.pyplot as plt

################################################################################################################################################
##### 2014
################################################################################################################################################

Data2014Plots = pd.read_csv()

### ECR/EFDD
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['ECR/EFDD 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['ECR/EFDD 2014'], color='navy')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['ECR/EFDD 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['ECR/EFDD 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['ECR/EFDD 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='navy')

### EPP
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['EPP 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['EPP 2014'], color='deepskyblue')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['EPP 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['EPP 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['EPP 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='deepskyblue')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### ALDE
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['ALDE 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['ALDE 2014'], color='gold')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['ALDE 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['ALDE 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['ALDE 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='gold')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### Greens/EFA
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['Greens/EFA 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['Greens/EFA 2014'], color='limegreen')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['Greens/EFA 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['Greens/EFA 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['Greens/EFA 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='limegreen')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### S&D
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['S&D 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['S&D 2014'], color='crimson')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['S&D 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['S&D 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['S&D 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='crimson')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### GUE/NGL
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['GUE/NGL 2014', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2014Plots[col], Data2014Plots['GUE/NGL 2014'], color='maroon')

    # Handle missing values
    if Data2014Plots[col].isnull().values.any():
        TempData2014Plots = Data2014Plots[['GUE/NGL 2014', col]].dropna()
    else:
        TempData2014Plots = Data2014Plots[['GUE/NGL 2014', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots['GUE/NGL 2014'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color='maroon')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### All at Once
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'ECR/EFDD 2014': 'navy',
    'EPP 2014': 'deepskyblue',
    'ALDE 2014': 'gold',
    'Greens/EFA 2014': 'limegreen',
    'S&D 2014': 'crimson',
    'GUE/NGL 2014': 'maroon'
}

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2014Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Iterate over each group
    for group, color in groups.items():
        if col != group:
            # Handle missing values
            if Data2014Plots[col].isnull().values.any():
                TempData2014Plots = Data2014Plots[[group, col]].dropna()
            else:
                TempData2014Plots = Data2014Plots[[group, col]]

            # Fit a line to the data
            a, b = np.polyfit(TempData2014Plots[col], TempData2014Plots[group], 1)

            # Add the line to the plot
            axs[x, y].plot(TempData2014Plots[col], a * TempData2014Plots[col] + b, color=color)
    
    # Set the title of the subplot
    axs[x, y].set_title(col)


################################################################################################################################################
##### 2019
################################################################################################################################################

Data2019Plots = pd.read_csv()

### ECR/ID
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['ECR/ID 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['ECR/ID 2019'], color='navy')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['ECR/ID 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['ECR/ID 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['ECR/ID 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='navy')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### EPP
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['EPP 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['EPP 2019'], color='deepskyblue')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['EPP 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['EPP 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['EPP 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='deepskyblue')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)
      
### RE
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['RE 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['RE 2019'], color='gold')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['RE 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['RE 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['RE 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='gold')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### Greens/EFA
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['Greens/EFA 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['Greens/EFA 2019'], color='limegreen')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['Greens/EFA 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['Greens/EFA 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['Greens/EFA 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='limegreen')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)


### S&D
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['S&D 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['S&D 2019'], color='crimson')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['S&D 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['S&D 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['S&D 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='crimson')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### GUE/NGL
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['GUE/NGL 2019', 'COUNTRY:', 'CODE:']

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Create the scatter plot
    axs[x, y].scatter(Data2019Plots[col], Data2019Plots['GUE/NGL 2019'], color='maroon')

    # Handle missing values
    if Data2019Plots[col].isnull().values.any():
        TempData2019Plots = Data2019Plots[['GUE/NGL 2019', col]].dropna()
    else:
        TempData2019Plots = Data2019Plots[['GUE/NGL 2019', col]]

    # Fit a line to the data
    a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots['GUE/NGL 2019'], 1)

    # Add the line to the plot
    axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color='maroon')
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

### All at Once
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'ECR/ID 2019': 'navy',
    'EPP 2019': 'deepskyblue',
    'RE 2019': 'gold',
    'Greens/EFA 2019': 'limegreen',
    'S&D 2019': 'crimson',
    'GUE/NGL 2019': 'maroon'
}

# Iterate over each column in the DataFrame
for i, col in enumerate(Data2019Plots.columns):
    if col in skip_columns:
        continue

    # Calculate the subplot position
    x, y = divmod(i, 5)

    # Iterate over each group
    for group, color in groups.items():
        if col != group:
            # Handle missing values
            if Data2019Plots[col].isnull().values.any():
                TempData2019Plots = Data2019Plots[[group, col]].dropna()
            else:
                TempData2019Plots = Data2019Plots[[group, col]]

            # Fit a line to the data
            a, b = np.polyfit(TempData2019Plots[col], TempData2019Plots[group], 1)

            # Add the line to the plot
            axs[x, y].plot(TempData2019Plots[col], a * TempData2019Plots[col] + b, color=color)
    
    # Set the title of the subplot
    axs[x, y].set_title(col)

################################################################################################################################################
##### Comparing 2014-2019
################################################################################################################################################

### ECR/EFDD & ECR/ID
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'ECR/EFDD 2014': 'royalblue',
    'ECR/ID 2019': 'midnightblue'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)

### EPP
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'EPP 2014': 'skyblue',
    'EPP 2019': 'dodgerblue'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)

### ALDE & RE
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'ALDE 2014': 'navajowhite',
    'RE 2019': 'orange'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)

### Greens/EFA
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'Greens/EFA 2014': 'lime',
    'Greens/EFA 2019': 'darkgreen'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)

### S&D
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'S&D 2014': 'lightsalmon',
    'S&D 2019': 'red'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)

### GUE/NGL
#####################################################

# Define the size of the plot
fig, axs = plt.subplots(17, 5, figsize=(15, 50))

# Define the columns to skip
skip_columns = ['COUNTRY:', 'CODE:']

# Define the groups and their corresponding colors
groups = {
    'GUE/NGL 2014': 'lightcoral',
    'GUE/NGL 2019': 'brown'
}

# Iterate over each DataFrame
for DataPlots in [Data2014Plots, Data2019Plots]:
    # Iterate over each column in the DataFrame
    for i, col in enumerate(DataPlots.columns):
        if col in skip_columns:
            continue

        # Calculate the subplot position
        x, y = divmod(i, 5)

        # Iterate over each group
        for group, color in groups.items():
            if col != group:
                # Handle missing values
                if DataPlots[col].isnull().values.any():
                    TempDataPlots = DataPlots[[group, col]].dropna()
                else:
                    TempDataPlots = DataPlots[[group, col]]

                # Fit a line to the data
                a, b = np.polyfit(TempDataPlots[col], TempDataPlots[group], 1)

                # Add the line to the plot
                axs[x, y].plot(TempDataPlots[col], a * TempDataPlots[col] + b, color=color)
        
        # Set the title of the subplot
        axs[x, y].set_title(col, fontsize=7)
