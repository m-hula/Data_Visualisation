library(tidyverse)

##reading in data sets
apps <- read.csv("https://query.data.world/s/vb4dtkfys5xqtzumeeph57lkmtlcw6?dws=00000", 
                 header=TRUE, stringsAsFactors=FALSE);
players <- read.csv("https://query.data.world/s/e3klc25uusii23tofhclalipwhlkca?dws=00000", 
                    header=TRUE, stringsAsFactors=FALSE);

##merging goals, assists, yellow, red cards, and minutes played from apps to the players subset
##First create an apps_subset
apps_subset <- apps[, c("player_id", "goals", "assists", "minutes_played", "yellow_cards", "red_cards")]

##add up duplicate player IDs as 1 player will play in multiple competitions. This adds up their total stats.
apps_subset <- apps_subset %>%
  group_by(player_id) %>%
  summarize(goals = sum(goals, na.rm = TRUE),
            assists = sum(assists, na.rm = TRUE),
            minutes_played = sum(minutes_played, na.rm = TRUE),
            yellow_cards = sum(yellow_cards, na.rm = TRUE),
            red_cards = sum(red_cards, na.rm = TRUE))

##now merge these columns to the players data frame
players <- merge(players, apps_subset, by = "player_id", all.x = TRUE)

##removing players with any missing values
players <- na.omit(players)

##creating a new column which adds a log function to the current market value column. And goals+assists total column 
players$log_market_value_eur <- log(players$market_value_in_eur)  
players <- transform(players, GA = players$goals + players$assists)  

##seeing how many players there are by each last_season they have played  
player_counts_by_year <- players %>% 
  group_by(last_season) %>% 
  summarise(count = n(), .groups = "drop")  

##creating a players data frame that only includes players with a last_season of 2022
current_players <- players[players$last_season == 2022,]

##seeing how many players there are in each league and from each nationality as of 2022
player_counts_by_league <- current_players %>%
  group_by(current_club_domestic_competition_id) %>%
  summarise(count = n(), .groups = "drop")

player_counts_by_citizenship <- current_players %>%
  group_by(country_of_citizenship) %>%
  summarise(count = n(), .groups = "drop")

##creating an age column. The data was last updated 8/12/2022 so base age of this
specific_date <- as.Date("2022-12-08")
current_players$age <- as.numeric(difftime(specific_date, current_players$date_of_birth,
                                       units="days")) / 365.25

##converting the age to integers and rounding down
current_players$age <- floor(current_players$age)

##creating a current players data set that only includes the 5 major leagues
major_league_players <- current_players[current_players$current_club_domestic_competition_id == 
                                          c("GB1", "FR1", "L1", "ES1", "IT1"),]

##creating a 2018-2022 (most samples/players) players data set that only includes the 5 major leagues
major_league_all_players <- players[players$current_club_domestic_competition_id == 
                                      c("GB1", "FR1", "L1", "ES1", "IT1"),]
major_league_all_players <- major_league_all_players[major_league_all_players$last_season == 
                                                       c(2018, 2019, 2020, 2021, 2022),]
  
  
  