# Forecastr
## A simple weather app

### User Story
- [x] As an unauthenticated user
  - [x] When I open the app
    - [x] Then I should see the current weather for Boulder, CO
    - [x] And the weather should include the text of temperature
    - [x] And the weather should include the text of current conditions
    - [x] And I should see a button titled “Forecast”
  - [x] When I click on the “Forecast” Button
    - [x] Then I should be taken to a new view
    - [x] And I should see the text of the forecast for the next 3 days

### Gotchas
- Free tier of WeatherAPI only allows 3 days of forecasts, not 5 as suggested in the initial prompt
### Future Improvements
- [ ] create error alert view
- [ ] use real location
- [ ] toggle between metric/standard units
- [ ] add RefreshControl to main view
- [ ] add additional condition info to views, i.e. change of snow/rain, UV index, etc.
- [ ] add view for hourly condition info
- [ ] push notifications for weather alerts
- [ ] "favorites" list to add more locations to track, utilize Search/Autocomplete API to search for location
