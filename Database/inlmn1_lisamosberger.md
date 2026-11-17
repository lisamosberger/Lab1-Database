# Part A: Enviroment and architecture
### Task 1

Start the MySQL container:
```powershell
docker run --name mysql-lab1 -p 3307:3306
-e MYSQL_ROOT_PASSWORD=secret -e 'MYSQL_ROOT_HOST=%' -d mysql:26.10.0
```

I then copied the Laboration1.sql file into my new created Intellij Project.
In Intellij I pressed on Databases, added Mysql and put in the username and password. 
Additionalli I changed the port to 3307.

#### Why port 3307?
Mysql uses port 3306 by default. On my computer, a container that is used 
for the lessons already used port 3306. Therefor I created this with port 3307 
so I can run it in the same time as my Lesson container. 

Mysql still listens on port 3306 and only the port outside of the container
is different.

#### Benefits: 
- Both containers can run at the same time.
- I do not have to stop or delete the lessons container, so its data is not affected
- The lab is kept separate from the lesson material. In intellij I use port 3306 for 
- the lessons and port 3307 for the lab

### Task 2: Show tables and describe
I wrote these commands in the console to get the following output.
```sql
 SHOW TABLES; 
 ```
| Tables\_in\_laboration1 |
| :--- |
| account |
| moon\_mission |
```sql
DESCRIBE account;
```
| Field | Type | Null | Key | Default | Extra |
| :--- | :--- | :--- | :--- | :--- | :--- |
| user\_id | smallint | NO | PRI | null | auto\_increment |
| name | varchar\(255\) | YES |  | null |  |
| password | varchar\(255\) | YES |  | null |  |
| first\_name | varchar\(255\) | YES |  | null |  |
| last\_name | varchar\(255\) | YES |  | null |  |
| ssn | varchar\(255\) | YES |  | null |  |

**Primary Key of `account`:** `user_id`
The `user_id` column is marked `PRI` in key column. 
It is `NOT NULL` and uses auto_increment. MySQL assigns a unique number to 
each new account automatically.

```sql
DESCRIBE moon_mission;
```
| Field | Type | Null | Key | Default | Extra |
| :--- | :--- | :--- | :--- | :--- | :--- |
| mission\_id | smallint | NO | PRI | null | auto\_increment |
| spacecraft | varchar\(255\) | YES |  | null |  |
| launch\_date | date | YES |  | null |  |
| carrier\_rocket | varchar\(255\) | YES |  | null |  |
| operator | varchar\(255\) | YES |  | null |  |
| mission\_type | varchar\(255\) | YES |  | null |  |
| outcome | varchar\(255\) | YES |  | null |  |

**Primary key of `moon_mission`:** `mission_id`
The `mission_id` column is marked `PRI` in the key column. It is 
`NOT NULL`and uses also auto_increment. MySQL assigns a unique number to each 
new mission automatically.



