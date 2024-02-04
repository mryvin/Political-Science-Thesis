<html lang="en">
<head>

</head>
<body>

<h1>🗳️ EU Election Prediction 🗳️</h1>

<p>This repository contains my political science thesis paper where I applied my knowledge in data science to create models predicting future EU elections based on the results of the 2014 and 2019 elections. More information about the study and its results can be found in Thesis Paper.pdf </p>

<p>In this project, I wanted to explore the factors that influence the voting behavior of the EU citizens and how they affect the distribution of seats among different political groups in the parliament. I used data from the 2014 and 2019 EU elections, as well as various independent variables such as economic indicators, population demographics, educational attainment, immigration statistics, and public opinion polls. I performed data cleaning, exploratory data analysis, and predictive modeling using Python and R. I also created some visualizations such as bar plots and maps to show the results and predictions.</p>

<h2>📚 Dataset Sources 🌐</h2>
<ul>
    <li><a href="https://www.imf.org/en/Publications/WEO/weo-database/2022/April">World Economic Outlook Database</a>: Economic data</li>
    <li><a href="https://ec.europa.eu/eurostat/databrowser/view/tps00010/default/table?lang=en">Eurostat</a>: Population data</li>
    <li><a href="https://ec.europa.eu/eurostat/databrowser/view/MIGR_IMM12PRV__custom_3387909/default/table?lang=en">European Commission</a>: Educational attainment data</li>
    <li><a href="https://ec.europa.eu/eurostat/databrowser/view/MIGR_IMM12PRV__custom_3387909/default/table?lang=en">European Commission</a>: Immigration data (1)</li>
    <li><a href="https://ec.europa.eu/eurostat/databrowser/view/LFST_RIMGPCGA__custom_3387949/default/table?lang=en">European Commission</a>: Immigrant Population data (2)</li>
    <li><a href="https://europa.eu/eurobarometer/surveys/detail/2040">Standard Eurobarometer 81 - Spring 2014</a>: Polling data for 2014</li>
    <li><a href="https://europa.eu/eurobarometer/surveys/detail/2253">Standard Eurobarometer 91 - Spring 2019</a>: Polling data for 2019</li>
</ul>

<h2>📁 Files and Folders 📂</h2>
<ul>
    <li><strong>Election Results</strong> folder: Contains election results for each country in the EU for the 2014 and 2019 elections. The files are named as <em>Country Name.csv</em>. There are 28, one for each of the 28 EU members at the time of the 2014 and 2019 elections.</li>
    <li><strong>Analysis.R</strong>: It contains R scripts for data analysis. It loads the Complete Data csv files and splits them into training and testing sets. It then applies various regression models such as linear regression, random forest, gradient boosting, and neural network to predict the vote share of each EU group in each country. It also evaluates the performance of the models using metrics such as mean absolute error, root mean squared error, and R-squared. It saves the best models as R objects in the same folder.</li>
    <li><strong>Complete Data 2014.csv</strong>, <strong>Complete Data 2019.csv</strong>, and <strong>Complete Data Total.csv</strong>: Contain datasets that combine election results and independent variables. They were created by running the Data Cleaning.py file. Each file has 28 rows, one for each country.</li>
    <li><strong>Data Cleaning.py</strong>: Used for cleaning and merging data from the Election Results folder and the Independent Variables.csv file. Performs some data wrangling tasks such as removing missing values, renaming columns, converting data types, aggregating data, and joining data. It then creates the Complete Data csv files.</li>
    <li><strong>Exploratory Data Analysis.py</strong>: Used to observe relationships between vote share of each political party and independent variables. </li>
    <li><strong>Independent Variables.csv</strong>: Contains data on the independent variables used in the study. The data was obtained from various sources as mentioned in the Dataset Sources section.</li>
    <li><strong>Maps.R</strong>: Used to create maps showing vote share based on actual election results and predictions from models found in Analysis.R.</li>
    <li><strong>Residual Bar Plots.R</strong>: Used to create residual bar plots for models on data. .</li>
    <li><strong>Thesis Paper.pdf</strong>: It is a compilation of all information into a paper on predicting vote share that each EU parliamentary group would get in future elections. It includes some tables and figures to illustrate the data and the findings.</li>
</ul>

</body>
</html>
