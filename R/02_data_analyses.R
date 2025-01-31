# Header ----------------------------------------------------------------
# Project: ten-rules
# File name: 02_data_analyses.R
# Last updated: 2025-01-30
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/ten-rules

# Load libraries --------------------------------------------------------
library(irr)

# Load data -------------------------------------------------------------
raw_archived <- read.csv("./data/raw_archived.csv")
data_cleaned <- read.csv("./data/data_cleaned.csv")
workflow_documented <- read.csv("./data/workflow_documented.csv")
processed_archived <- read.csv("./data/processed_archived.csv")

# Fleiss' Kappa ---------------------------------------------------------
# Raw
kappam.fleiss(ratings = raw_archived[, 2:10], exact = FALSE, detail = FALSE)
# Clean
kappam.fleiss(ratings = data_cleaned[, 2:10], exact = FALSE, detail = FALSE)
# Workflow
kappam.fleiss(ratings = workflow_documented[, 2:10], exact = FALSE, detail = FALSE)
# Processed
kappam.fleiss(ratings = processed_archived[, 2:10], exact = FALSE, detail = FALSE)
