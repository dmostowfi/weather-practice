# DON'T CHANGE THIS CODE
# ----------------------
require "net/http"
require "json"
url = "https://weatherdbi.herokuapp.com/data/weather/chicago"
uri = URI(url)
response = Net::HTTP.get(uri)
weather_data = JSON.parse(response)
# ----------------------

# EXERCISE
# Using the Ruby hash `weather_data` that includes weather forecast data for Chicago,
# write a weather summary out to the screen including the current conditions and upcoming forecast.
# Something like the output below.

# Sample output:
# In Chicago, IL it is currently 67 degrees and cloudy.
# The rest of today will be a high of 65 and scattered shows.
# The upcomming weather forecast is:
# Wednesday: a high of 65 and scattered showers.
# Thursday: a high of 67 and partly cloudy.
# Friday: a high of 59 and rain.
# Saturday: a high of 77 and cloudy.
# ...

# STEPS
# Look at the weather_data hash.
# Find the current data.
# Build a string with the text and dynamic data from the hash.
# "In #{...} it is currently #{...} degrees and #{...}"
# Find the array of forecast data.
# Read only the first element of that array to display the conditions for the rest of today.
# Use a loop to display the daily summary for the upcoming forecast.

# 1. inspect the weather_data hash
 #puts weather_data

puts "In #{weather_data["region"]} it is currently #{weather_data["currentConditions"]["temp"]["f"]} degrees and #{weather_data["currentConditions"]["comment"]}"

upcoming_forecast = weather_data["next_days"]

puts "The upcoming weather forecast is..."
for day in upcoming_forecast
    puts "#{day["day"]}: a high of #{day["max_temp"]["f"]} and #{day["comment"]}"
end 

#another way to do it - this version is nicer to your future self
for daily_forecast_data in weather_data["next_days"]
    day_of_week = daily_forecast_data["day"]
    high_temp = daily_forecast_data["max_temp"]["f"]
    conditions = daily_forecast_data["comment"]
    puts "#{day_of_week}: a high of #{high_temp} and #{conditions}."
  end



# CHALLENGE
# Can you display the weather forecast summary for a user-entered city?
# Use the following code at the very top of the file and then replace "chicago" in the api url with the user-entered city:
# puts "What city are you in?"
# city = gets.chomp
# puts city
# Note: what happens if the user-entered value is not a known city? You'll want to do some error handling.

puts "What city are you in?"
city = gets.chomp
puts city
city = city.gsub(" ", "") #this gets rid of the space in New York so that you can enter it in the URL
puts city

if weather_data["status"] == "fail"

# ----------------------
require "net/http"
require "json"
url = "https://weatherdbi.herokuapp.com/data/weather/#{city}"
uri = URI(url)
response = Net::HTTP.get(uri)
weather_data = JSON.parse(response)
# ----------------------

# 1. inspect the weather_data hash
# puts weather_data

# 2. check if user submits an unknown city and handle edge case
if weather_data["status"] == "fail"
    # 3. display error message to the user
    puts "we don't know that city.  try again."
    # 4. otherwise, display weather summary for city
else
    # 5. get the current temp and conditions
    current_temp = weather_data["currentConditions"]["temp"]["f"]
    current_condition = weather_data["currentConditions"]["comment"]

# 6. display string with region, current temp and conditions
puts "In #{weather_data["region"]} it is currently #{current_temp} and #{current_condition}."