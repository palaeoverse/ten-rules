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

# Data wrangling --------------------------------------------------------
data <- data %>%
  select(-timestamp, -method, -most_recent) %>% 
  arrange(evaluator, publication) %>%
  pivot_longer(cols = raw_archived:processed_archived) %>% 
  group_by(publication, name, value) %>%
  summarise(count = length(value))
  

data$publication <- sub(pattern = "PBDB #", 
                        replacement = "", 
                        x = data$publication)  
data$publication <- sub(pattern = " - .*", 
                        replacement = "", 
                        x = data$publication)   
data$publication <- as.numeric(data$publication)

# Save data
write.csv(data, "./data/summary_data.csv", row.names = FALSE)

