#Beginning Case study 1: Analyzing BikeShare data for company Cyclistic

#Loading useful packages (already installed)
library(tidyverse)
library(lubridate)
library(janitor)

#June 2021 - May 2022  bikeshare data was downloaded from 
#https://divvy-tripdata.s3.amazonaws.com/index.html in 12 separate csv files
#Those csv files are in the current working directory

############## IMPORTING, CLEANING, AND ADDING VARIABLES #####################

#Reading in files
cy2021_06 <- read_csv("202106-tripdata.csv")
cy2021_07 <- read_csv("202107-tripdata.csv")
cy2021_08 <- read_csv("202108-tripdata.csv")
cy2021_09 <- read_csv("202109-tripdata.csv")
cy2021_10 <- read_csv("202110-tripdata.csv")
cy2021_11 <- read_csv("202111-tripdata.csv")
cy2021_12 <- read_csv("202112-tripdata.csv")
cy2022_01 <- read_csv("202201-tripdata.csv")
cy2022_02 <- read_csv("202202-tripdata.csv")
cy2022_03 <- read_csv("202203-tripdata.csv")
cy2022_04 <- read_csv("202204-tripdata.csv")
cy2022_05 <- read_csv("202205-tripdata.csv")

#Checking to make sure column names are all identical before merging - They are
colnames(cy2021_06)
colnames(cy2021_07)
colnames(cy2021_08)
colnames(cy2021_09)
colnames(cy2021_10)
colnames(cy2021_11)
colnames(cy2021_12)
colnames(cy2022_01)
colnames(cy2022_02)
colnames(cy2022_03)
colnames(cy2022_04)
colnames(cy2022_05)

#Checking for any inconsistencies - all data types are congruent
#Note that id variables are characters, not numeric
str(cy2021_06)
str(cy2021_07)
str(cy2021_08)
str(cy2021_09)
str(cy2021_10)
str(cy2021_11)
str(cy2021_12)
str(cy2022_01)
str(cy2022_02)
str(cy2022_03)
str(cy2022_04)
str(cy2022_05)

#Merging
all_trips <- bind_rows(cy2021_06, cy2021_07, cy2021_08, cy2021_09, cy2021_10, 
  cy2021_11, cy2021_12, cy2022_01, cy2022_02, cy2022_03, cy2022_04, cy2022_05)

#Checking data to make sure merging worked as intended
colnames(all_trips)
str(all_trips_v2)
nrow(all_trips)
dim(all_trips)
head(all_trips)
tail(all_trips)
summary(all_trips)

#Creating separate variables for day, month, year, and hour
all_trips$date <- as.Date(all_trips$started_at)
all_trips$month <- format(as.Date(all_trips$started_at), "%m")
all_trips$day <- format(as.Date(all_trips$started_at), "%d")
all_trips$year <- format(as.Date(all_trips$started_at), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$started_at), "%A")
all_trips$hour <- format(as_datetime(all_trips$started_at), "%H")

#Creating a ride duration variable
all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)

#Seeing column structure and data type
str(all_trips)
is.numeric(all_trips$ride_length)

#Changing data type to numeric for calculations
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

#Removing data with negative ride lengths
min(all_trips$ride_length)
all_trips_v2 <- all_trips %>% 
  filter(all_trips$ride_length >= 0)

#To double check that the filtering above worked correctly...
test_trips <- all_trips %>% 
  filter(all_trips$ride_length < 0)

# 139 obs have negative trip lengths, matching the number of obs filtered out


#################### ANALYZING NEWLY CLEANED DATASET ########################

#Examining Ride Length First
#For mean, median, min, and max
summary(all_trips_v2$ride_length)

#Getting feel for the shape of our data. Positive skew may bias averages.
ggplot(data = all_trips_v2, aes(x = ride_length)) + geom_histogram() +xlim(c(0,10000))


#separated by membership status
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)

#To order days of week correctly for next analysis
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, 
  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
             "Saturday"))

#Viewing patterns of ride length for casual riders and members...
#By days of the week
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)
#By months of the year
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$month, FUN = mean)
#By type of bike
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$rideable_type, FUN = mean)

#Making some tables just to get a better understanding
#Will upload and do final graphing in Excel
#Analyze ride data by type and weekday
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label=TRUE)) %>%
  group_by(member_casual, weekday) %>% 
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label=TRUE)) %>%
  group_by(member_casual, month) %>% 
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, month)

#Again with visuals for number of riders by rider type
#Want to graph this in Excel
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label=TRUE)) %>%
  group_by(member_casual, weekday) %>% 
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(mapping = aes(x = weekday, y = number_of_rides, 
              fill = member_casual)) + geom_col(position = "dodge")

#Visualizing for average duration now
#Also will graph in Excel
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label=TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(mapping = aes(x = weekday, y = average_duration, 
              fill = member_casual)) + geom_col(position = "dodge")


################## CREATING CSV FILES FOR EXCEL GRAPHING #######################

#For ride length by day of week
len_dw <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
                        all_trips_v2$day_of_week, FUN = mean)

write.csv(len_dw, file = 'XXX\\avg_ride_lengthdaysweek.csv')

#For ride length by month of year
len_m <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
                       all_trips_v2$month, FUN = mean)

write.csv(len_m, file = 'XXX\\avg_ride_lengthmonth.csv')

#For number of rides by month of year
counts_m <- tabyl(all_trips_v2, member_casual, month, show_na = TRUE)
write.csv(counts_m, file = 'XXX\\num_ridesmonth.csv')

#For number of rides by day of week
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, 
  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
             "Saturday"))
counts_dw <- tabyl(all_trips_v2, member_casual, day_of_week, show_na = TRUE)
write.csv(counts_dw, file = 'XXX\\num_ridesdaysweek.csv')

#For number of rides by hour
counts_h <- tabyl(all_trips_v2, member_casual, hour, show_na = TRUE)
write.csv(counts_h, file = 'XXX\\num_rideshour.csv')


######################## CREATING R PLOT ##################################

#Plot will examine relationship of ride frequency across time of day and day of
#week, for casual and member riders

#Creating vectors to be used for updating facet labels in the graph below
member_casual.labs <- c(
  "casual" = "Casual Riders",
  "member" = "Member Riders")
day_of_week.labs <- c(
  "Sunday" = "Sun",
  "Monday" = "Mon",
  "Tuesday" = "Tues",
  "Wednesday" = "Wed",
  "Thursday" = "Thurs",
  "Friday" = "Fri",
  "Saturday" = "Sat")

#Making sure day of week variable is ordered correctly beforehand
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, 
levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
  "Saturday"))

#Plotting a more comprehensive picture of when people ride
ggplot(data = all_trips_v2, mapping = aes(x = hour, fill = member_casual)) + 
  geom_bar() + scale_fill_manual(values = c("#E1BE6A" , "#40B0A6")) +
  facet_grid(day_of_week ~ member_casual, 
        labeller = labeller(day_of_week = day_of_week.labs, 
         member_casual = member_casual.labs)) + 
  theme_bw() + 
  labs(title = "When Do People Ride?", 
        subtitle = 
        "Plotting Casual Rider and Member Trends Summed over Day of the Week") +
  theme(plot.title = element_text(hjust=0.5), 
        plot.subtitle = element_text(hjust=0.5),
        legend.position = "none",
        axis.text.x = element_text(size = 8), 
        axis.text.y = element_text(size = 8)) +
  theme(strip.text.x = element_text(size = 10), 
        strip.text.y = element_text(size = 10)) +
  scale_x_discrete(name = "Time of Day", 
        breaks = c("03", "06", "09", "12", "15", "18", "21"), 
        labels = c("3am", "6am", "9am", "12pm", "3pm", "6pm", "9pm")) +
  scale_y_continuous(name = "Number of Rides", 
        breaks = c(0, 30000, 60000), 
        labels = c("0", "30k", "60k"))

#Saving
ggsave("WhenDoPeopleRide3.png")

