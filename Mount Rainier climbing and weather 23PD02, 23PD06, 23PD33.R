# Load necessary libraries
library(ggplot2)
library(corrplot)
library(dplyr)
library(car)  # For QQ plots
library(broom)  # For tidy summary of models

# Load the datasets
climbing_data <- read.csv("C:/Users/psivk/Documents/MAXON/SEM3/R prog/climbing_statistics.csv")
weather_data <- read.csv("C:/Users/psivk/Documents/MAXON/SEM3/R prog/Rainier_Weather.csv")

# Convert 'Date' column to Date format
climbing_data$Date <- as.Date(climbing_data$Date, format="%m/%d/%Y")
weather_data$Date <- as.Date(weather_data$Date, format="%m/%d/%Y")

# Merge the datasets on 'Date'
merged_data <- inner_join(climbing_data, weather_data, by = "Date")

# View the first few rows
print(head(merged_data))

# Select relevant columns for correlation
selected_columns <- merged_data %>%
  select(Success.Percentage, Temperature.AVG, Relative.Humidity.AVG, Wind.Speed.Daily.AVG, Solar.Radiation.AVG)
print("Selected Columns for columns :")
print(head(selected_columns))



# Calculate the correlation matrix
cor_matrix <- cor(selected_columns, use = "complete.obs")
cat("Correlation Matrix\n", cor_matrix, "\n")

# Plot the correlation matrix
corrplot(cor_matrix, method = "color", type = "upper", tl.col = "black", tl.cex = 0.8, addCoef.col = "black")

# Scatter plots for visual analysis
tempvssuccess <- ggplot(merged_data, aes(x = Temperature.AVG, y = Success.Percentage)) +
  geom_point() + 
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Temperature vs Success Percentage", x = "Average Temperature", y = "Success Percentage")

relvssuccess <- ggplot(merged_data, aes(x = Relative.Humidity.AVG, y = Success.Percentage)) +
  geom_point() + 
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Relative Humidity vs Success Percentage", x = "Relative Humidity", y = "Success Percentage")

windvssuccess <- ggplot(merged_data, aes(x = Wind.Speed.Daily.AVG, y = Success.Percentage)) +
  geom_point() + 
  geom_smooth(method = "lm", col = "green") +
  labs(title = "Wind Speed vs Success Percentage", x = "Average Wind Speed", y = "Success Percentage")

solarvssuccess <- ggplot(merged_data, aes(x = Solar.Radiation.AVG, y = Success.Percentage)) +
  geom_point() + 
  geom_smooth(method = "lm", col = "orange") +
  labs(title = "Solar Radiation vs Success Percentage", x = "Average Solar Radiation", y = "Success Percentage")

print(tempvssuccess)
print(relvssuccess)
print(windvssuccess)
print(solarvssuccess)

# Histogram for Success Percentage
successHist <- ggplot(merged_data, aes(x = Success.Percentage)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Success Percentage", x = "Success Percentage", y = "Frequency")

# Boxplots to explore weather variables
tempbox <- ggplot(merged_data, aes(y = Temperature.AVG)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot of Average Temperature", y = "Average Temperature")

relhumidbox <- ggplot(merged_data, aes(y = Relative.Humidity.AVG)) +
  geom_boxplot(fill = "lightcoral") +
  labs(title = "Boxplot of Relative Humidity", y = "Relative Humidity")

windbox <- ggplot(merged_data, aes(y = Wind.Speed.Daily.AVG)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Boxplot of Wind Speed", y = "Wind Speed")

solarbox <- ggplot(merged_data, aes(y = Solar.Radiation.AVG)) +
  geom_boxplot(fill = "lightyellow") +
  labs(title = "Boxplot of Solar Radiation", y = "Solar Radiation")

# Pairwise scatter plots with trend lines
tempvshumidscatter <- ggplot(merged_data, aes(x = Temperature.AVG, y = Relative.Humidity.AVG)) +
  geom_point() +
  geom_smooth(method = "lm", col = "purple") +
  labs(title = "Temperature vs Relative Humidity", x = "Average Temperature", y = "Relative Humidity")

windvssolarscatter <- ggplot(merged_data, aes(x = Wind.Speed.Daily.AVG, y = Solar.Radiation.AVG)) +
  geom_point() +
  geom_smooth(method = "lm", col = "brown") +
  labs(title = "Wind Speed vs Solar Radiation", x = "Average Wind Speed", y = "Solar Radiation")

print(tempbox)
print(relhumidbox)
print(windbox)
print(solarbox)
print(tempvshumidscatter)
print(windvssolarscatter)

# Central Tendencies
# Calculate mean and median for each variable
central_tendencies <- selected_columns %>%
  summarise(
    Success_Percentage_Mean = mean(Success.Percentage, na.rm = TRUE),
    Success_Percentage_Median = median(Success.Percentage, na.rm = TRUE),
    
    Temperature_Mean = mean(Temperature.AVG, na.rm = TRUE),
    Temperature_Median = median(Temperature.AVG, na.rm = TRUE),
    
    Humidity_Mean = mean(Relative.Humidity.AVG, na.rm = TRUE),
    Humidity_Median = median(Relative.Humidity.AVG, na.rm = TRUE),
    
    Wind_Speed_Mean = mean(Wind.Speed.Daily.AVG, na.rm = TRUE),
    Wind_Speed_Median = median(Wind.Speed.Daily.AVG, na.rm = TRUE),
    
    Solar_Radiation_Mean = mean(Solar.Radiation.AVG, na.rm = TRUE),
    Solar_Radiation_Median = median(Solar.Radiation.AVG, na.rm = TRUE)
  )

# Print central tendencies
print(central_tendencies)

# QQ Plots to check normality of the variables
# Success Percentage
qqPlot(merged_data$Success.Percentage, main = "QQ Plot: Success Percentage", ylab = "Success Percentage Quantiles")

# Temperature
qqPlot(merged_data$Temperature.AVG, main = "QQ Plot: Temperature", ylab = "Temperature Quantiles")

# Relative Humidity
qqPlot(merged_data$Relative.Humidity.AVG, main = "QQ Plot: Relative Humidity", ylab = "Relative Humidity Quantiles")

# Wind Speed
qqPlot(merged_data$Wind.Speed.Daily.AVG, main = "QQ Plot: Wind Speed", ylab = "Wind Speed Quantiles")

# Solar Radiation
qqPlot(merged_data$Solar.Radiation.AVG, main = "QQ Plot: Solar Radiation", ylab = "Solar Radiation Quantiles")

# Hypothesis Testing: Z-Test for Success Percentage
# Categorizing Success Levels
print("Hypothesis Testing: Z-Test for Success Percentage")
merged_data$Success.Level <- ifelse(merged_data$Success.Percentage > median(merged_data$Success.Percentage, na.rm = TRUE), "High", "Low")

# Calculate means and standard deviations for each group
mean_high <- mean(merged_data$Success.Percentage[merged_data$Success.Level == "High"], na.rm = TRUE)
mean_low <- mean(merged_data$Success.Percentage[merged_data$Success.Level == "Low"], na.rm = TRUE)

sd_high <- sd(merged_data$Success.Percentage[merged_data$Success.Level == "High"], na.rm = TRUE)
sd_low <- sd(merged_data$Success.Percentage[merged_data$Success.Level == "Low"], na.rm = TRUE)

n_high <- sum(!is.na(merged_data$Success.Percentage[merged_data$Success.Level == "High"]))
n_low <- sum(!is.na(merged_data$Success.Percentage[merged_data$Success.Level == "Low"]))

# Z-Test formula
z_value <- (mean_high - mean_low) / sqrt((sd_high^2 / n_high) + (sd_low^2 / n_low))
print(paste("Z-Value: ", z_value))

# Calculate the p-value for the two-tailed test
p_value <- 2 * (1 - pnorm(abs(z_value)))
print(paste("P-Value: ", p_value))

# Interpret results
alpha <- 0.05
if (p_value < alpha) {
  print("Reject the null hypothesis: There is a significant difference in success percentage between High and Low groups.")
} else {
  print("Fail to reject the null hypothesis: There is no significant difference in success percentage between High and Low groups.")
}


# Build a linear regression model
model <- lm(Success.Percentage ~ Temperature.AVG + Relative.Humidity.AVG + Wind.Speed.Daily.AVG + Solar.Radiation.AVG, 
            data = merged_data)

# Summary of the model
print(summary(model))

# ANOVA Analysis
anova_model <- aov(Success.Percentage ~ Temperature.AVG + Relative.Humidity.AVG + Wind.Speed.Daily.AVG + Solar.Radiation.AVG, data = merged_data)
anova_summary <- summary(anova_model)
print(anova_summary)

# Create a prediction dataset with sample weather values
new_data <- data.frame(
  Temperature.AVG = c(30, 40, 50),
  Relative.Humidity.AVG = c(50, 60, 70),
  Wind.Speed.Daily.AVG = c(10, 20, 15),
  Solar.Radiation.AVG = c(200, 300, 250)
)
print("Model Predictions:")
# Predict success percentage using the model
predictions <- predict(model, newdata = new_data)

# Print predictions
print(predictions)

# Plot predictions vs actual data
linear <- ggplot(merged_data, aes(x = Temperature.AVG, y = Success.Percentage)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Linear Regression: Temperature vs Success Percentage")
print(linear)
