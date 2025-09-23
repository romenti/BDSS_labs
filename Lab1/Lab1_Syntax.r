# R Script for Data Analysis
# Author: Nicola Barban
# Date: 2023-09-21
# Description: This script contains various R code snippets for data analysis and visualization.

# Load necessary libraries
library(tidyverse)
library(gapminder)

# Load and explore the 'table1' dataset
# (Replace 'table1' with your actual dataset name)
table1

# Calculate a new variable 'newvar' and display it
newvar <- 1000 * table1$cases / table1$population
newvar

# Calculate 'rate' and add it as a new column to 'table1'
table1 <- mutate(table1, rate = 1000 * cases / population)
table1

# Count the number of cases by year in 'table1'
table1 |> 
  count(year, wt = cases)

# Create a line plot with 'table1' data
table1 |> 
  ggplot(aes(x = year, y = cases, color = country)) +
  geom_line() +
  geom_point()

# Explore the 'gapminder' dataset for Asia after 1985
gapminder_asia <- gapminder |> 
  filter(continent == "Asia", year >= 1985) 
head(gapminder_asia)

# Select specific columns from 'gapminder' dataset
gapminder_LE <- gapminder |> 
  select(country, continent, year, lifeExp) 
gapminder_LE

# Filter and select specific columns from 'gapminder' dataset
gapminder_selection <- gapminder |> 
  select(country, continent, year, lifeExp) |> 
  filter(continent == "Asia", year >= 1985) 
str(gapminder_selection)

# Sort 'table1' by population in descending order
table1 |>  
  arrange(desc(population))

# Explore the 'pivot' vignette
vignette("pivot")

# Explore and pivot the 'relig_income' dataset
relig_income

relig_income |> 
  pivot_longer(cols = !religion, 
               names_to = "income", 
               values_to = "count")

# Explore the 'gapminder_selection' dataset
gapminder_selection

# Pivot the 'gapminder_selection' dataset to wide format
gapminder_selection |> 
  pivot_wider(id_cols = country, names_from = year, values_from = lifeExp)

# Pivot the 'gapminder_selection' dataset to long format
gapminder_selection |> 
  pivot_wider(id_cols = country,
              names_from = year, 
              values_from = lifeExp) |> 
  pivot_longer(cols = !country, 
               names_to = "year",
               values_to = "lifeExp")

# Create a scatter plot using the 'iris' dataset
ggplot(iris, 
       aes(x = Sepal.Length,
           y = Sepal.Width, 
           color = Species)) + 
  geom_point(size = 6) +
  theme_dark()

# Summarize the 'iris' dataset by 'Species'
iris |> 
  group_by(Species) |> 
  summarise(AvgLength = mean(Sepal.Length),
            N = length(Sepal.Length))