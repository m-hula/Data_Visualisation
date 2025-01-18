##creating a data set that doesn't include players position = goalkeeper or missing
outfield_players <- major_league_players[!major_league_players$position %in% c("Goalkeeper", "Missing"),]

##creating total number of goals by a league + player position. 
goals_by_position_league <- outfield_players %>%
  group_by(current_club_domestic_competition_id, position) %>%
  summarise(total_goals = sum(goals, na.rm = TRUE)) %>%
  ungroup()

##visualising total goals by each position in each league, and have it in descending order
ggplot(goals_by_position_league, 
       aes(x = reorder(current_club_domestic_competition_id, -total_goals), y = total_goals, fill = position)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = total_goals), position = position_stack(vjust = 0.5), size = 3, color = "white") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Total goals for each position across leagues", x="League", y="Total goals", 
       caption="As of 08/12/2022") +
  scale_x_discrete(labels = c(
    "GB1" = "English\nPremier League",
    "ES1" = "Spanish\nLa Liga",
    "FR1" = "French\nLigue 1",
    "IT1" = "Italian\nSerie A",
    "L1" = "German\nBundesliga"))
  
  
  
