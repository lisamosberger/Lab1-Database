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





(write about how I changed by my own mission by select id to name, because 
the thing that sets automaticall ID continues counting even if i remove something
(Asked AI about that why it got the second time I added my mission again after deleting it 
a new number and not the same as before))

