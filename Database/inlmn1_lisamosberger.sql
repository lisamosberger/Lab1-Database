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

-- Task 8: Get three most recently launched missions
select * from moon_mission
order by launch_date
like 3;

-- Task 9: Get all accounts with the last name Åström or Fransson, sorted by first name
select * from account
where last_name = 'Åström' or last_name = 'Fransson'
order by first_name;

-- Task 10: Get all missions where operator = 'NASA'
select * from moon_mission
where operator = 'NASA';
/*
 I only get 0 rows, because if we take a look on the table moon_missions
 we see that there is no NASA to find. Every NASA has spaces between some letters (NA  SA,NAS A)
 so it finds nothing.
 */

-- Task 11: get all missions where mission_type = 'Impactor'
select * from moon_mission
where Trim(mission_type) = 'Impactor';
-- added "Trim()" after the first search
/*
 I only got one row, but in the table there are two Impactor. But one of them
 has a space infront of it, which causes this problem. With the help of trim I could find
 also the Impactor with the space infront.
 */

-- Task 12: Work with your own mission
-- Task 12a: Insert a new mission (launched before the year 2000) and show it
insert into moon_mission (spacecraft, launch_date, carrier_rocket, operator, mission_type, outcome)
values ('Apollo 11', '1969-07-16',
        'Saturn V', 'NASA',
        'Crewed lunar landing', 'Successful');
-- It got the mission_id = 19
select * from moon_mission
where spacecraft = 'Apollo 11';

-- Task 12b: Change the outcome of the mission with update
update moon_mission set outcome = 'Launch failure'
where spacecraft = 'Apollo 11';

select * from moon_mission
where spacecraft = 'Apollo 11';

-- Task 12c: Delete the mission with delete, using where on mission_id
delete from moon_mission
where spacecraft = 'Apollo 11';

select * from moon_mission
where spacecraft = 'Apollo 11';

-- Task 13: Change the outcome of Chandrayaan-2 to Sucessfull
update moon_mission set outcome = 'Sucessfull'
where spacecraft = 'Chandrayaan-2';

select *
from moon_mission where spacecraft = 'Chandrayaan-2';
-- Task 14: Delete all mission launched in 2010 or later
delete from moon_mission
where launch_date >= '2010-01-01';


