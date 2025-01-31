# Header ----------------------------------------------------------------
# Project: ten-rules
# File name: 01_data_wrangling.R
# Last updated: 2025-01-30
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/ten-rules

# Load libraries --------------------------------------------------------
library(tidyverse)

# Load data -------------------------------------------------------------
data <- read.csv("./data/raw/PBDB_publication_evaluation.csv")

# Data cleaning ---------------------------------------------------------
data <- data %>% 
  group_by(evaluator, publication) %>%
  mutate(most_recent = order(timestamp, decreasing = TRUE)) %>%
  filter(most_recent == 1)

# Exclude publications?
# exc_pub <- unique(data$publication[which(data$include == "No")])
# data <- data %>%
#   filter(!publication %in% exc_pub)

# Data wrangling --------------------------------------------------------
## Analyses formatting --------------------------------------------------
# Raw archived
raw_archived <- data %>%
  select(publication, evaluator, raw_archived) %>%
  pivot_wider(names_from = evaluator, values_from = raw_archived)
write.csv(raw_archived, "data/raw_archived.csv", row.names = FALSE)
# Data cleaned
data_cleaned <- data %>%
  select(publication, evaluator, data_cleaned) %>%
  pivot_wider(names_from = evaluator, values_from = data_cleaned)
write.csv(data_cleaned, "data/data_cleaned.csv", row.names = FALSE)
# Workflow doucmented
workflow_documented <- data %>%
  select(publication, evaluator, workflow_documented) %>%
  pivot_wider(names_from = evaluator, values_from = workflow_documented)
write.csv(workflow_documented, "data/workflow_documented.csv", row.names = FALSE)
# Processed archived
processed_archived <- data %>%
  select(publication, evaluator, processed_archived) %>%
  pivot_wider(names_from = evaluator, values_from = processed_archived)
write.csv(processed_archived, "data/processed_archived.csv", row.names = FALSE)

# Plot format
data <- data %>%
  select(-timestamp, -method, -most_recent) %>% 
  arrange(evaluator, publication) %>%
  pivot_longer(cols = raw_archived:processed_archived) %>% 
  group_by(publication, name, value) %>%
  summarise(count = length(value))

## Plot formatting ------------------------------------------------------
data$publication <- sub(pattern = "PBDB #", 
                        replacement = "", 
                        x = data$publication)  
data$publication <- sub(pattern = " - .*", 
                        replacement = "", 
                        x = data$publication)   
data$publication <- as.numeric(data$publication)

# Save data
write.csv(data, "./data/plot_data.csv", row.names = FALSE)
