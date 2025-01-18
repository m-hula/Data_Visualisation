library(treemapify)


##getting the total market value and number of players for each league
mv_and_count_by_league <- major_league_players %>%
  group_by(current_club_domestic_competition_id) %>%
  summarise(
    total_market_value = sum(market_value_in_eur, na.rm = TRUE),  
    player_count = n()) %>%
  ungroup()

##adding suitable labels for the leagues
mv_and_count_by_league$custom_league_name <- 
  league_labels[mv_and_count_by_league$current_club_domestic_competition_id]

##plotting the distribution of market value across the leagues
ggplot(mv_and_count_by_league,
       aes(area = total_market_value, label = custom_league_name, fill = player_count)) +
  geom_treemap() +
  geom_treemap_text() +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +  
  labs(title = "Distribution of footballer market value throughout leagues", caption = "As of 08/12/2022")
