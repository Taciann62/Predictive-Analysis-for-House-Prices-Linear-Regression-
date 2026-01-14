library(tidyverse)
library(skimr)
library(janitor)
library(ggcorrplot)
library(car)


# --- 1. Load Data ---


# --- 2. Data Cleaning (Outlier Treatment) ---
# Filter Price Outliers
Q1_p <- quantile(Housing$price, 0.25)
Q3_p <- quantile(Housing$price, 0.75)
IQR_p <- Q3_p - Q1_p
Housing <- subset(Housing, price >= (Q1_p - 1.5 * IQR_p) & price <= (Q3_p + 1.5 * IQR_p))

# Filter Area Outliers
Q1_a <- quantile(Housing$area, 0.25)
Q3_a <- quantile(Housing$area, 0.75)
IQR_a <- Q3_a - Q1_a
Housing <- subset(Housing, area >= (Q1_a - 1.5 * IQR_a) & area <= (Q3_a + 1.5 * IQR_a))

# --- 3. Data Preparation (Manual Mapping & Dummies) ---
# Map Binary Variables (Yes/No to 1/0)
varlist <- c('mainroad', 'guestroom', 'basement', 'hotwaterheating', 'airconditioning', 'prefarea')
Housing[varlist] <- lapply(Housing[varlist], function(x) ifelse(x == "yes", 1, 0))

# Create Dummy Variables for Furnishing Status (Dropping first level to avoid dummy trap)
# This creates 'furnishingstatussemi-furnished' and 'furnishingstatusunfurnished'
dummies <- as.data.frame(model.matrix(~ furnishingstatus - 1, data = Housing))
Housing <- cbind(Housing, dummies[, -1]) 

Housing<- Housing %>% 
  select(-furnishingstatus) # Remove original text column

## Correlation Visualization:
cor_matrix <- cor(Housing, use = "complete.obs")

ggcorrplot(cor_matrix, 
           hc.order = TRUE,  # Cluster correlated variables
           type = "lower",   # Show lower triangle
           lab = FALSE,       # Show correlation numbers
           lab_size = 4,
           method = "circle",
           colors = c("red", "white", "blue"),  # Negative = red, positive = blue
           title = "Fig 1. No outlier Correlation Heatmap of Housing Features")


Heat Map

cor_long <- as.data.frame(as.table(cor_matrix))

colnames(cor_long) <- c("Feature1", "Feature2", "Correlation")

ggplot(cor_long, aes(x = Feature1, y = Feature2, fill = Correlation)) +
  geom_tile(color = "white") +  # each square
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  coord_fixed() +
  labs(title = "No outlier Heatmap of Housing Features Correlation")


# --- 4. Split Data (70% Train, 30% Test) ---

## Select which features will be trained following the identification of the ones with high correlation with Price.  

Housing_Features <- Housing %>% 
  select(price, area, bathrooms, stories, airconditioning, parking, prefarea)


set.seed(123)
train_excerpt <- sample(1:nrow(Housing_Features), 0.7 * nrow(Housing_Features))
train_data <- Housing_Features[train_excerpt, ]
test_data  <- Housing_Features[-train_excerpt, ]



plot: pairs(train_data, main = "Fig 3: Correlation of Train Data", col = "Green")


# --- 5. Model Building (Using selected featurs that share string correlation with Price) ---
model_final <- lm(price ~ ., data = train_data)

summary(model_final)
Call:
  lm(formula = price ~ ., data = train_data)

Residuals:
  Min       1Q   Median       3Q      Max 
-2865614  -582294   -93360   593213  3690372 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)     699216.63  197492.86   3.540 0.000453 ***
  area               278.92      30.92   9.020  < 2e-16 ***
  bathrooms       998698.72  117863.79   8.473 6.49e-16 ***
  stories         408917.95   62225.82   6.572 1.78e-10 ***
  airconditioning 805237.77  114161.31   7.054 9.22e-12 ***
  parking         127414.62   63718.90   2.000 0.046303 *  
  prefarea        778361.94  123793.64   6.288 9.50e-10 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 932400 on 354 degrees of freedom
Multiple R-squared:  0.6262,	Adjusted R-squared:  0.6198 
F-statistic: 98.82 on 6 and 354 DF,  p-value: < 2.2e-16



## Model Plot
plot(model_final$fitted.values, resid(model_final),
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")

hist(resid(model_final),
     breaks = 30,
     main = "Histogram of Residuals",
     col = "lightblue")

qqnorm(resid(model_final))
qqline(resid(model_final), col = "red")

abs_resid <- abs(resid(model_final))
plot(model_final$fitted.values, abs_resid,
     xlab = "Fitted values",
     ylab = "Absolute residuals",
     main = "Homoscedasticity check")
     



# --- 7. Model Diagnostics (The "Health Check") ---
par(mfrow = c(2, 2)) # Create a 2x2 grid for plots
plot(model_final)

# --- 8. Model Evaluation (Test Set R-Squared) ---
predictions <- predict(model_final, newdata = test_data)

actuals <- test_data$price

mse <- mean((predictions - actuals)^2)
rmse <- sqrt(mse)


summary(predictions)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
2618923 3542783 4325502 4557165 5456729 7763140 


# Calculate R-Squared manually: 1 - (RSS / TSS)
rss <- sum((test_data$price - predictions)^2)
tss <- sum((test_data$price - mean(test_data$price))^2)
test_r2 <- 1 - (rss / tss)

# Final Result
cat("\n--- Final Evaluation ---\n")
cat("Test R-squared:", round(test_r2, 4), "\n")
view: Test R-squared: 0.5638

vif(model_final) # If numbers are under 5, you are safe!
area       bathrooms         stories airconditioning 
1.275248        1.159342        1.225049        1.180259 
parking        prefarea 
1.186399        1.047464


shapiro.test(resid(model_final))
#Result Shapiro-Wilk normality test
Shapiro-Wilk normality test

data:  resid(model_final)
W = 0.98189, p-value = 0.0001671

## Result: data:  resid(model_final)

anova(model_final)
Analysis of Variance Table

Response: price
Df     Sum Sq    Mean Sq  F value    Pr(>F)    
area              1 2.2663e+14 2.2663e+14 260.7041 < 2.2e-16 ***
  bathrooms         1 1.4091e+14 1.4091e+14 162.0879 < 2.2e-16 ***
  stories           1 6.2461e+13 6.2461e+13  71.8509 6.349e-16 ***
  airconditioning   1 4.7543e+13 4.7543e+13  54.6905 1.030e-12 ***
  parking           1 3.5281e+12 3.5281e+12   4.0585   0.04471 *  
  prefarea          1 3.4367e+13 3.4367e+13  39.5336 9.498e-10 ***
  Residuals       354 3.0774e+14 8.6932e+11                       
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


getwd()