# Header ----------------------------------------------------------------
# Project: ten-rules
# File name: 03_data_visualisation.R
# Last updated: 2025-01-30
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/ten-rules

# Load libraries --------------------------------------------------------
library(ggplot2)
library(MetBrewer)
library(scales)


# Load data -------------------------------------------------------------
data <- read.csv("./data/summary_data.csv")
# Breaks for yaxis
brks <- c(0, 0.25, 0.5, 0.75, 1)
# Rename categories
data$name[which(data$name == "raw_archived")] <- "Raw data archived"
data$name[which(data$name == "data_cleaned")] <- "Raw data cleaned"
data$name[which(data$name == "workflow_documented")] <- "Workflow documented"
data$name[which(data$name == "processed_archived")] <- "Processed data archived"
# Set factor levels for plotting
data$name <- factor(data$name, levels = c("Raw data archived",
                                          "Raw data cleaned",
                                          "Workflow documented",
                                          "Processed data archived"))
data$value <- factor(data$value, levels = c("Yes", "No"))

ggplot(data = data, aes(x = as.factor(publication), y = count, fill = value)) +
  geom_col(colour = "black", linewidth = 0.25, position = "fill") +
  facet_wrap(~name) +
  scale_fill_met_d("Hokusai2") +
  scale_y_continuous(breaks = brks, labels = scales::percent(brks)) +
  xlab("Publication #") +
  ylab("Percentage (%)") +
  theme(
    legend.title = element_blank(),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  )

# Save plot
ggsave("figures/publication_evaluation.png", dpi = 600,
       width = 200, height = 200, units = "mm", scale = 1)
