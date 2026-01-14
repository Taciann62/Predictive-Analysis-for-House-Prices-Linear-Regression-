# Housing Cost Prediction

Housing Price Prediction Analysis
Introduction

This project focuses on building a predictive model to understand the key factors influencing housing prices. Using structured housing data, statistical techniques, and linear regression, the analysis aims to identify strong price drivers and evaluate model performance using rigorous diagnostics.

Project Overview

The dataset contains housing attributes such as property size, number of bathrooms, stories, parking availability, air conditioning, and location preference.
The objective is to clean the data, explore relationships between variables, and develop a regression model that explains housing price variations while ensuring statistical validity.

My Role

I acted as a Data Analyst, responsible for data cleaning, feature preparation, exploratory analysis, model building, and performance evaluation.
This project strengthened my understanding of regression assumptions, multicollinearity checks, and model diagnostics in R.

Data Analytics Objectives

Clean and preprocess housing data

Treat outliers using the IQR method

Encode categorical variables

Analyze feature correlations

Build and validate a multiple linear regression model

Evaluate model performance on unseen data

Tools

R Studio – Data analysis and modeling

tidyverse, janitor, skimr – Data wrangling

ggcorrplot, ggplot2 – Visualization

car – Model diagnostics (VIF)

Data Preparation & Cleaning

Removed price and area outliers using the Interquartile Range (IQR) method

Converted binary categorical variables (Yes/No) into numerical format

Created dummy variables for furnishing status to avoid the dummy variable trap

Removed undefined or redundant features

Exploratory Data Analysis
Correlation Analysis

A correlation matrix and heatmap were used to identify variables strongly associated with housing price.

Key Insights:

Area, bathrooms, stories, air conditioning, and preferred location showed strong positive correlation with price

Low multicollinearity confirmed through VIF values (< 5)

(Visualization: Correlation Heatmap)

Model Building

A Multiple Linear Regression model was built using selected high-correlation features:

Selected Features:

Area

Bathrooms

Stories

Air Conditioning

Parking

Preferred Area

Model Performance
Training Results

Adjusted R²: 0.6198

Model explains ~62% of price variation

All predictors were statistically significant (p < 0.05)

Test Set Evaluation

Test R²: 0.5638

Indicates strong generalization to unseen data

Model Diagnostics

Residual plots showed no strong heteroscedasticity

VIF values confirmed absence of multicollinearity

Shapiro-Wilk test indicated slight deviation from normality, acceptable given large sample size

(Visuals: Residual plots, QQ plot, histogram)

Key Insights

Area and number of bathrooms are the strongest predictors of housing price

Properties in preferred locations command significantly higher prices

Air conditioning and number of stories also have substantial price impact

Business Implications

Real estate pricing strategies should prioritize property size and amenities

Developers can increase valuation by focusing on preferred areas and modern facilities

Buyers can better assess value drivers when comparing properties

Conclusion

This analysis demonstrates how regression modeling can be used to explain and predict housing prices with strong statistical grounding. The model provides actionable insights while maintaining interpretability, making it suitable for real-world real estate decision-making.



If you want it even shorter (GitHub one-liner), here’s an option:

Predictive housing price analysis using linear regression to identify key price drivers and forecast property values.
