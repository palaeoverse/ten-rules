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

# Load and wrangle data -------------------------------------------------
data <- read.csv("./data/plot_data.csv")
# Breaks for yaxis
brks <- c(0, 0.25, 0.5, 0.75, 1)
# Rename categories
data$name[which(data$name == "raw_archived")] <- "Have the raw occurrence data data archived?"
data$name[which(data$name == "data_cleaned")] <- "Have the occurrence data been cleaned?"
data$name[which(data$name == "workflow_documented")] <- "Has the workflow been documented?"
data$name[which(data$name == "processed_archived")] <- "Have the processed occurrence data been archived?"
# Set factor levels for plotting
data$name <- factor(data$name, levels = c("Have the raw occurrence data data archived?",
                                          "Have the occurrence data been cleaned?",
                                          "Has the workflow been documented?",
                                          "Have the processed occurrence data been archived?"))
data$value <- factor(data$value, levels = c("Yes", "No"))


# Plot by question ------------------------------------------------------

ggplot(data = data, aes(x = as.factor(publication), y = count, fill = value)) +
  geom_col(colour = "black", linewidth = 0.25, position = "fill") +
  facet_wrap(~name) +
  scale_fill_met_d("Derain", direction = 1) +
  scale_y_continuous(breaks = brks, labels = scales::percent(brks)) +
  xlab("Publication #") +
  ylab("Percentage (%)") +
  theme_bw() +
  theme(
    legend.title = element_blank(),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  )

# Save plot
ggsave("figures/publication_evaluation_question.png", dpi = 600,
       width = 250, height = 200, units = "mm", scale = 1)

# Plot by publication ---------------------------------------------------

ggplot(data = data, aes(x = as.factor(name), y = count, fill = value)) +
  geom_col(colour = "black", linewidth = 0.25, position = "fill") +
  facet_wrap(~publication) +
  scale_fill_met_d("Derain", direction = 1) +
  scale_y_continuous(breaks = brks, labels = scales::percent(brks)) +
  xlab("Evaluation question") +
  ylab("Percentage (%)") +
  theme_bw() +
  theme(
    legend.title = element_blank(),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  )

# Save plot
ggsave("figures/publication_evaluation_pub.png", dpi = 600,
       width = 210, height = 297, units = "mm", scale = 1)
