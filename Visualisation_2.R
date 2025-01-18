##box plot showing the distribution of age of players by league
ggplot(major_league_players, 
       aes(current_club_domestic_competition_id, age, fill = current_club_domestic_competition_id)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2, colour = "black", lwd=0.6) +
  geom_hline(yintercept = median(major_league_players$age, na.rm = TRUE), colour = "darkred", 
             size = 1.5, linetype = "dashed") +
  labs(title = "Distribution of Player Ages by League", x = "League", y = "Age", fill = "League" ,
       caption = "As of 08/12/2022") +
  theme_minimal() +
  theme(axis.text.x = element_text()) +
  scale_x_discrete(labels = c(
    "GB1" = "English\nPremier League",
    "ES1" = "Spanish\nLa Liga",
    "FR1" = "French\nLigue 1",
    "IT1" = "Italian\nSerie A",
    "L1" = "German\nBundesliga")) +
  guides(fill = "none")
