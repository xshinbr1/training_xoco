library(targets)

source("R/functions.R")

# Set target-specific options such as packages:
tar_option_set(packages = "tidyverse")

# End this file with a list of target objects.
list(
  # create data
  tar_target(name = file,
             command = create_penguin_data(out_path = "data/penguin_data.csv"),
             packages = c("readr", "janitor")),
  # clean data
  tar_target(name = data,
             command = clean_data(file_path = file),
             packages = c("readr", "dplyr", "tidyr", "stringr", "lubridate")),
  # plot data
  tar_target(name = plot_data,
             command = exploratory_plot(clean_data = data),
             packages = "ggplot2")
  
)
