# Housing Cost Prediction

## Introduction

This project focuses on building a predictive model to understand the key factors influencing housing prices. Using structured housing data, statistical techniques, and linear regression, the analysis aims to identify strong price drivers and evaluate model performance using rigorous diagnostics.

### Project Overview
The dataset contains housing attributes such as property size, number of bathrooms, number of stories, parking availability, air conditioning, and location preference.
The objective is to clean the data, explore relationships between variables, and develop a regression model that explains housing price variations while ensuring statistical validity.

### My Role
I acted as a Data Analyst, responsible for data cleaning, feature preparation, exploratory analysis, model building, and performance evaluation.
This project strengthened my understanding of regression assumptions, multicollinearity checks, and model diagnostics in R.

#### Data Analytics Objectives
- Clean and preprocess housing data
- Treat outliers using the IQR method
- Encode categorical variables
- Analyze feature correlations
- Build and validate a multiple linear regression model
- Evaluate model performance on unseen data

### Tools
- R Studio – Data analysis and modeling
- Visualization
- Model diagnostics (VIF)


### Data Preparation & Cleaning
- Removed price and area outliers using the Interquartile Range (IQR) method
- Converted binary categorical variables (Yes/No) into numerical format
- Created dummy variables for furnishing status to avoid the dummy variable trap
- Removed undefined or redundant features
- Exploratory Data Analysis
- Correlation Analysis

A correlation matrix and a heatmap were used to identify variables strongly associated with housing prices.

Key Insights:
Area, bathrooms, stories, air conditioning, and preferred location showed strong positive correlation with price

<img width="968" height="519" alt="Correlation of Train Data" src="https://github.com/user-attachments/assets/e31e884e-3bca-43cc-afd5-f9ecaad23cda" />

<img width="792" height="519" alt="Fig 1  No outlier Correlation Heatmap of Housing Features" src="https://github.com/user-attachments/assets/7aba866b-7952-480b-a208-614c7ef19282" />

<img width="817" height="519" alt="No outlier Heatmap of Housing Features Correlation" src="https://github.com/user-attachments/assets/639eea10-3658-492a-adb9-bde6788d54e8" />


Low multicollinearity confirmed through VIF values (< 5)

(Visualization: Correlation Heatmap)

Model Building
A Multiple Linear Regression model was built using selected high-correlation features:
Selected Features:
- Area
- Bathrooms
- Stories
- Air Conditioning
- Parking
- Preferred Area
- Model Performance

```R
Min.    2,618,923
1st Qu. 3,542,783
Median  4,325,502
Mean    4,557,165
3rd Qu. 5,456,729
Max.    7,763,140

```

Training Results
Adjusted R²: 0.6198

The model explains ~62% of price variation

All predictors were statistically significant (p < 0.05)

#### Test Set Evaluation
Test R²: 0.5638 = Indicates strong generalization to unseen data

Model Diagnostics
Residual plots showed no strong heteroscedasticity

<img width="1266" height="519" alt="Plot of Model" src="https://github.com/user-attachments/assets/570bb462-0277-46a0-8282-219143529756" />


VIF values confirmed the absence of multicollinearity

The Shapiro-Wilk test indicated a slight deviation from normality, acceptable given the large sample size

(Visuals: Residual plots, QQ plot, histogram)

#### Key Insights

- Area and number of bathrooms are the strongest predictors of housing price

- Properties in preferred locations command significantly higher prices

- Air conditioning and the number of stories also have a substantial price impact



### Business Implications and Recommendations

- Real estate pricing strategies should prioritize property size and amenities

- Developers can increase valuation by focusing on preferred areas and modern facilities

- Buyers can better assess value drivers when comparing properties
- House prices are driven mainly by size, location, and comfort features, and these factors can reliably predict property values using regression.


#### Conclusion

This analysis demonstrates how regression modeling can be used to explain and predict housing prices with strong statistical grounding. The model provides actionable insights while maintaining interpretability, making it suitable for real-world real estate decision-making.

