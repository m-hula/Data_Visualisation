##filtering the top 10 nationalities of each league
top_nationalities <- major_league_players %>%
  count(country_of_citizenship) %>%
  top_n(10, n)

##creating a copy of major_league_players that only includes player from the 10 most common countries
top_10_nationalities_players <- major_league_players %>%
  filter(country_of_citizenship %in% top_nationalities$country_of_citizenship)


##Summarising nationality data
nationalities_by_league <- top_10_nationalities_players %>%
  group_by(current_club_domestic_competition_id, country_of_citizenship) %>%
  tally() %>%
  ungroup()

# Create the heatmap
ggplot(nationalities_by_league, aes(x = current_club_domestic_competition_id, y = country_of_citizenship, fill = n)) +
  geom_tile() +
  labs(title = "Heatmap of Players Nationalities Across Leagues", x = "League", y = "Nationality", 
       fill = "Player Count", caption="As of 08/12/2022") +
  scale_fill_gradient2(midpoint=27, low="white", mid="blue", high="black") +
  scale_x_discrete(labels = league_labels) +
  theme_minimal()
