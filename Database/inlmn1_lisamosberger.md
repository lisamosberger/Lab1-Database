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

### Task 3: Architecture 

**Where they run** 
- **MySQL Server:** in the Docker container `mysql-lab1`. Docker runs on my own computer
(localhost), which means the server is on my own machine.
- **Client:** Intellij, running on my computer.

**How they communicate**  
The client connects to the server over TCP (Transmission Control Protocol) using 
the MySQL console. It sends the SQL statements and the server executes them and returns
the result. Docker sends the connection from the host port to the container 
port (`-p 3307:3306`)

- Port **3307** is the port on my computer. This is the one the client connects to
- Port **3306** is the port inside the container, where MySQL listens.

**Port Used**  
- Client connects to: `localhost`
- MySQL listens on: `3306` (inside the container)

# Part C: SQL eller NoSQL? 

**SQL** database like MySQL store data in tables with rows and columns.
The structure is decided in advance and tables are 
linked with primary and foreign keys that follow ACDI, 
so transactions are reliable and the data stays consistent. 

**NoSQL** database don't store data in tables. Instead the data can be stored as documents, key-value pairs
or graphs. They don't need a fixed structure, which means each record can look different. They are often 
faster and easier to spread over many servers, but they are usually less strict about keeping data consistent.

### Task 15: Bank transfers between accounts
**SQL** 
A transfer needs to fully suceed or not happen at all, which means no money disappeared if something
crashes. SQL database guarantees this with ACID transactions. 

### Task 16: Login sessions in a web shop with automatic expiry after 30 minutes
**NoSQL**
A session that ends after 30 minutes can be seen as only a key (session ID) with a value (user information).
NoSQL are fast and have a build in expiry Time, so sessions are deletet automatically after 30 minutes. 

### Task 17: A product catalog where different product types have completely different attributes
**NoSQL** 
For a catalog with different products with different attributes is a NoSQL a better fit, documents can have 
different fields without a fixed table. SQL would lead to many empty (null) columns, that's why 
NoSQL is the better choice here. 


# Part D: Reflection (VG)
### Task 18: Which questions did you get help with from AI? 

While working on the first lab I used an AI for in total four questions. Two were about the enviroment
(a Docker port error) and the database behaviour (`AUTO_INCREMENT`) and the other two were about SQL
(removing extra spaces and writing an `INSERT`).
The AI gave useful answers everytime, but because it didn't know the exact tables and tasks I needed to fix some 
small issues in the insert part. 

**My promt** 
> ccf54d02cbd9dcfd90e7d6faf4eae4ea7d8f824b8c7a069d9dfe0ee4b298970f
docker: Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint mysql-lab1 (b9f9f2cf3b740ba9df0ac9178cb41e9579aadd6542b746016c6b36d79a957693): Bind for 0.0.0.0:3306 failed: port is already allocated   
> 
> I wanted to run a new conatiner and got this error message, I understand that it means that the port is already used. But in what way can I fix this?

**AI answer**
> You have two options: free up port 3306 or map the new container to a different host port.

**1. Find out what's using the port**

```bash
docker ps -a --filter "publish=3306"
```

Most likely an older container (maybe another MySQL one) is holding it. If it's a leftover you don't need:

```bash
docker stop <name>
docker rm <name>      # only if you want to delete it
```

Also check that your failed `mysql-lab1` isn't itself stuck in "Created" state. If it is, run `docker rm mysql-lab1` before retrying, otherwise you'll get a name conflict.

If it isn't a container, something on the host is using the port, such as a locally installed MySQL service:

```bash
sudo lsof -i :3306        # Linux/macOS
netstat -ano | findstr 3306   # Windows
```

You can stop that service (e.g. `sudo systemctl stop mysql`) if you don't need it.

**2. Use a different host port**

The port mapping is `host:container`. Only the left side needs to be unique, so keep MySQL listening on 3306 inside the container and expose it on another port outside:

```bash
docker run --name mysql-lab1 -e MYSQL_ROOT_PASSWORD=secret -p 3307:3306 -d mysql:8
```

You then connect to `localhost:3307` from your host. This is the best choice if you want to run several MySQL containers side by side, for example `3307`, `3308`, and so on for each lab.

If another container needs to reach MySQL, put them on the same Docker network and connect to `mysql-lab1:3306`. You don't need to publish a port for that.

**How I fixed it**   
As described in Task 1, I used `-p 3307:3306` instead of `-p 3306:3306`. Port 3307 on my computer is forwarded 
to port 3306 inside the container, so the two containers don't conflict.

**The Second question I asked**  
**My Promt**
> How can I remove extra spaces when using select * from moon_mission where mission_type = 'something';

**AI answer**
>It depends on where the extra spaces are.

**1. Spaces in the data making the match fail**

If the stored value is `'something '` (trailing space) or `' something'`, your `=` won't match. Use `TRIM`:

```sql
SELECT * FROM moon_mission
WHERE TRIM(mission_type) = 'something';
```

`TRIM` removes both leading and trailing spaces. `LTRIM` and `RTRIM` do one side each. Note that MySQL ignores trailing spaces in `=` comparisons for `CHAR`/`VARCHAR` with most collations, so leading spaces are the more common culprit. Wrapping a column in a function also stops MySQL from using an index on it, which doesn't matter for a lab table.

**2. Spaces in the output**

If the result looks too wide in the terminal, that's just the client padding columns to the column width, not real spaces. Options:

```sql
SELECT TRIM(mission_type) AS mission_type, ... FROM moon_mission ...;
```

or end the query with `\G` instead of `;` to print each row vertically:

```sql
SELECT * FROM moon_mission WHERE mission_type = 'something'\G
```

**3. Cleaning the data permanently**

If you want to fix the stored values:

```sql
UPDATE moon_mission
SET mission_type = TRIM(mission_type);
```

If you're unsure which case you have, run `SELECT CONCAT('[', mission_type, ']') FROM moon_mission;`. The brackets make any leading or trailing spaces visible.

**Third quesion I asked**  
**My Promt**
> Can you create a moon mission in this format: insert into moon_mission (spacecraft, launch_date, carrier_rocket, operator, mission_type, outcome)

**AI answer**
> Here's an example using a real mission (Apollo 11):

```sql
INSERT INTO moon_mission (spacecraft, launch_date, carrier_rocket, operator, mission_type, outcome)
VALUES ('Apollo 11', '1969-07-16',
        'Saturn V', 'NASA', 'Crewed lunar landing', 'Successful');
```

A few things to check against your table:

- **Date format:** MySQL expects `'YYYY-MM-DD'` for a `DATE` column.
- **Value formats:** use whatever your existing rows use for `mission_type` and `outcome` (e.g. `'Successful'` vs `'Success'`), or your `WHERE mission_type = '...'` queries won't match.
- **Multiple rows:** you can insert several at once by adding more value tuples:

```sql
INSERT INTO moon_mission (spacecraft, launch_date, carrier_rocket, operator, mission_type, outcome)
VALUES
  ('Apollo 11', '1969-07-16', 'Saturn V', 'NASA', 'Crewed lunar landing', 'Successful'),
  ('Luna 2', '1959-09-12', 'Luna 8K72', 'Soviet Union', 'Impactor', 'Successful'),
  ('Chandrayaan-3', '2023-07-14', 'LVM3', 'ISRO', 'Lander and rover', 'Successful');
```

If the table has an auto-increment `id` column, leave it out as above and MySQL fills it in.

**How I fixed it**  
From the AI's answer I first chose one randomly (Chandrayaan-3) but then saw later that 
it didn't launch before 2000 like the task asked for. I checked the format of the names and the date
so it fits to the others. When I wrote insert and pressed enter the AI of Intellij 
automatically added also `mission_id` to insert. But because it is automatically assigned to the missions 
I removed it.

**Last question I ased**  
**My promt**
> When I am adding a new mission to that table (each mission gets a ID number automatically assigned) and deleting it afterward, when adding a new mission again the number is instead of 19, 20
why is that so?

**AI answer** 
> That's how `AUTO_INCREMENT` works: the counter only ever goes up and is never reused when you delete a row. If the last ID was 19 and you delete that row, the next insert still gets 20, because the table remembers "next value = 20" independently of which rows currently exist.

This is intentional. IDs are meant to be unique identifiers, not row counts, and reusing them could cause problems (for example, another table referencing a deleted mission's ID would suddenly point to a different mission).

If you really want to reset it, e.g. in a lab environment:

```sql
ALTER TABLE moon_mission AUTO_INCREMENT = 19;
```

MySQL will only accept a value higher than the current maximum ID in the table, so if you've deleted row 19 and the highest remaining ID is 18, setting it to 19 works. If you set it lower than the existing maximum, it silently adjusts to max + 1.

You can check the current counter with:

```sql
SHOW TABLE STATUS LIKE 'moon_mission';
```

Look at the `Auto_increment` column.

Two other things that cause gaps: a failed or rolled-back `INSERT` also consumes a number, and in InnoDB, a server restart on older MySQL versions (before 8.0) could reset the counter to max + 1. So you shouldn't rely on IDs being gapless. If you need a sequential count, use `ROW_NUMBER()` in a query instead.

**How I used it**
I tried it more than once to run the `INSERT` into the table, and used first to find the ID = 19 
to write it down into the table. But after the first time of deleting it the mission_id number 
changed to 20 instead of 19. I then asked AI why this happend, and this answer was really useful for me to 
fully understand the `AUTO_INCREMENT`. 

### Task 19: Why is the account table a bad design for a password
The password in the `account` table are saved as plain text, which means it is open for anyone who can see the 
database to read every password and log in as any user. Several users with similar also share the exactly same password (for example the three Max(Maximillian and Maximus)),
which means that if anyone finds out one password, knows it for all of those accounts.
Aditionally, the `ssn` is stored in the same table so a single leak exposes both the login details and personal data

