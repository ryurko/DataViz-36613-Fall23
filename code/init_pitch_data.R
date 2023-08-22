# PURPOSE: Grab Ohtani's pitches from 2022 season so far

library(baseballr)

# Scrape pitches thrown by Ohtani this year
pitches_data <- 
  statcast_search(start_date = "2022-01-01", 
                  end_date = "2022-09-16",
                  playerid = 660271,
                  player_type = "pitcher") 

library(tidyverse)

clean_pitches_data <- pitches_data %>%
  dplyr::select(pitcher, pitch_type, release_speed,
                pfx_z, pfx_x, release_spin_rate, spin_axis,
                release_pos_x, release_pos_z, release_extension,
                plate_z, plate_x, stand) %>%
  filter(!is.na(plate_x), !is.na(plate_z))


# Save this file:
write_csv(clean_pitches_data, 
          "data/ohtani_pitches_2022.csv")
