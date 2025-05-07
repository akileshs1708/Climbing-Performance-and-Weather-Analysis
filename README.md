# Climbing-Performance-and-Weather-Analysis

This project analyzes the relationship between various weather conditions and climbing success percentages in **Mount Rainier** using data from two sources: climbing statistics and weather conditions. The analysis includes exploratory data analysis (EDA), correlation analysis, hypothesis testing, and linear regression modeling to understand how weather factors impact climbing success rates.

## Project Overview

The dataset contains climbing success percentages alongside environmental factors like temperature, humidity, wind speed, and solar radiation. The goal of this project is to uncover significant trends and provide predictive insights into climbing performance based on weather data.

### Key Steps in the Analysis:

1. **Data Preprocessing:**
   - Load and merge climbing and weather datasets by date.
   - Convert date columns into Date format for easy manipulation.

2. **Exploratory Data Analysis (EDA):**
   - Visualize relationships between weather variables and climbing success using scatter plots and correlation matrices.
   - Plot histograms and boxplots to understand distributions and outliers.

3. **Correlation Analysis:**
   - Calculate and visualize correlations between success percentage and weather variables.

4. **Hypothesis Testing:**
   - Perform a Z-test to check for significant differences between high and low success groups.

5. **Modeling:**
   - Build a linear regression model to predict climbing success based on weather conditions.
   - Conduct an ANOVA test to analyze the impact of individual weather variables.
   - Make predictions with the trained model.

6. **Prediction:**
   - Use the linear regression model to predict success percentages under various weather conditions.

---

## Requirements

- **R**: The analysis is performed using the R programming language.
- **Packages**: 
  - `ggplot2` (for data visualization)
  - `corrplot` (for correlation matrix visualization)
  - `dplyr` (for data manipulation)
  - `car` (for QQ plots and VIF)
  - `broom` (for tidy model summaries)

---

## Files

- **climbing_statistics.csv**: Climbing success data.
- **Rainier_Weather.csv**: Weather data, including temperature, humidity, wind speed, and solar radiation.
- **Climbing_Performance_Weather_Analysis.R**: R script containing the full analysis.

---

## How to Run

1. **Install Dependencies**: Install the required R packages if not already installed.
    ```r
    install.packages(c("ggplot2", "corrplot", "dplyr", "car", "broom"))
    ```

2. **Load Data**: Place the `climbing_statistics.csv` and `Rainier_Weather.csv` files in your working directory or adjust the paths in the R script accordingly.

3. **Run the Script**: Run the `Climbing_Performance_Weather_Analysis.R` script in RStudio or any R environment.

---

## Results

The analysis provides insights into how different weather variables (temperature, humidity, wind speed, and solar radiation) correlate with climbing success. The linear regression model allows for predictions based on various weather scenarios, which can help climbers and planners optimize their strategies for success.

---

