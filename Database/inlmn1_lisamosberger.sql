-- Part B

-- Task 4: Get Spacecraft, launch_date and outcome for all missions
select spacecraft, launch_date, outcome
from moon_mission;

-- Task 5: Get all missions where the outcome is Launch failure
select * from moon_mission
where outcome = 'launch failure';

-- Task 6: Get all missions launched before 1960, oldest first
select * from moon_mission
where launch_date < '1960-01-01'
order by launch_date asc;

-- Task 7: Get all missions whose name starts with Luna, sorted alphabetically
select *
from moon_mission
where spacecraft LIKE 'Luna %'
order by spacecraft;

/*
 I got 5 missions, I wasn't thinking about getting Lunar, but it also starts with "Luna".
 After I got the first list I added a space after Luna (Luna %) to get the table without Lunar.
 So I went from "Luna%" to "Luna %".
 */