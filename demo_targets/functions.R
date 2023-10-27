#create_penguin data ----
create_penguin_data <- function(out_path) {
  
  penguin_data <- palmerpenguins::penguins_raw %% janitor::clean_names()
  
  write_csv(penguin_data, out_path)
  
  return(out_path)
}

#clean data
clean_data <- function(file_path) {
  
  clean_data <- read_csv(file_path)%>%
    mutate(
      species = str_exract(string = species, 
                           pattern- "Chinstrap|Adelie|Gentoo"),
      year = lubridate::year(data_egg)
    )%>%
    select(species,
           island,
           flipper_length_mm,
           body_mass_g,
           sex)%>%
    drop_na()
  
  return(clean_data)
}


# exploratory_plot ----
exploratory_plot <- function(clean_data) {
  
  ggplot(data = clean_data, aes(x = flipper_length_mm,
                                y = body_mass_g)) +
    geom_point(aes(color = species)) +
    scale_color_manual(values = c(
      "Adelie" = "purple2",
      "Chinstrap" = "orange",
      "Gentoo" = "cyan4"
    )) +
    labs(
      title = NULL,
      x = "Flipper Length (mm)",
      y = "Body Mass (g)",
      color = "Species"
    ) +
    theme_minimal()
  
  ggsave("figs/exploratory_plot.png", width = 5, height = 5)
}
