# Package Generator for Dose Study

This is the repository for report generator for dose study.

![Screenshot](https://raw.githubusercontent.com/estone96/AnalysisDoseResp/main/assets/image1.png)

This package generates report from results of dose study package for user-defined index drugs by utilizing R shiny GUI and determines the cutoff level of maximum AUC using logistic regression, support vector machine and one-class support vector machine by utilizing generalized propensity score analysis. 

## Features
- This package automatically generates report for result using dose study package by using user-defined names for 4 target outcome condition groups
- Users can automatically generate reports by supplied R Shiny GUI app. 

## Usage
1. Access R shiny webpage by cloning this repository and launch Rproj file in R Studio application.

2. Copy all generated files in dose study package folder.

3. Launch app.R and click upper right 'Run App' in R Studio application.

4. Supply user-defined names for condition groups.

5. Click 'Get Report' button on sidebar to generate report.
