#########################################################
# Week 1 Clean Script - World Population Growth
# Author: <Your Name>
# Date: <Date>
# Description:
#   This script demonstrates good coding practices:
#   - Clean, readable code
#   - Reproducible workflow using tidyverse
#   - Relative paths, project organization
#########################################################

# ===========================
# 1. Setup
# ===========================

# Load required packages
library(tidyverse)

# Define paths
data_path <- "data/UNpop_messy.csv"
output_path <- "outputs/clean_population_results.csv"

# ===========================
# 2. Load data
# ===========================
unpop <- read_csv(data_path)

# Inspect structure
glimpse(unpop)

# ===========================
# 3. Transform data
# ===========================
# Goal:
# - Calculate population growth relative to 1950
# - Express as percentage increase
# - Flag years where increase > 120%

pop_growth <- unpop |>
  mutate(
    ratio = world.pop / first(world.pop),       # growth ratio relative to 1950
    percent = round((ratio - 1) * 100, 1),      # percentage increase
    high_growth_flag = percent > 120            # TRUE if increase > 120%
  )

# View transformed data
print(pop_growth)

# ===========================
# 4. Visualization
# ===========================
# Line plot of percent growth over time
pop_plot <- ggplot(pop_growth, aes(x = year, y = percent)) +
  geom_line(color = "blue", linewidth = 1.2) +
  geom_point(color = "darkblue", size = 3) +
  geom_hline(yintercept = 120, linetype = "dashed", color = "red") +
  labs(
    title = "World Population Growth Since 1950",
    subtitle = "Percentage increase relative to 1950",
    x = "Year",
    y = "Population increase (%)"
  ) +
  theme_minimal()

# Save plot to outputs folder
ggsave("outputs/population_growth_plot.png", pop_plot, width = 7, height = 5)

# ===========================
# 5. Save clean results
# ===========================
pop_growth |>
  arrange(year) |>
  write_csv(output_path)

message("Clean analysis complete. Results saved to outputs folder.")

# ===========================
# 6. Next steps / ideas
# ===========================
# - Extend analysis with more countries or regions
# - Create a Quarto report combining code and interpretation
# - Push project to GitHub for collaboration