--Write a query that returns guests with a birthday before 2000. 
SELECT * FROM guests WHERE gst_birthday < '2000/01/01'
--Write a query to return rooms that cost more than 100 gold a night
SELECT * FROM rooms WHERE cost_per_night > 100
--Write a query that returns UNIQUE guest names. 
SELECT DISTINCT gst_first_name, gst_last_name FROM guests
--Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]
SELECT gst_first_name, gst_last_name FROM guests 
ORDER BY gst_first_name ASC
--Write a query that returns the top 10 highest price sales
select TOP(10) * FROM supply_sales ORDER BY total DESC;
--Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference typically with just an ID and a name. This should be a dynamic combining of all of the tables
SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE 
(COLUMN_NAME LIKE '%id' OR COLUMN_NAME LIKE '%name');
--Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)
SELECT level, class_name_name, gst_first_name, gst_last_name,
CASE  
WHEN level BETWEEN 1 AND 10 THEN '1-10'
WHEN level BETWEEN 11 AND 20 THEN '11-20'
WHEN level BETWEEN 21 AND 30 THEN '21-30'
WHEN level BETWEEN 31 AND 40 THEN '31-40'
ELSE  '41+'
END 
AS Groups
FROM guest_class_link AS CL
JOIN class_names AS CN ON CN.class_name_id = CL.class_name_id
JOIN guests AS G on G.guest_id = CL.guest_id order by gst_last_name
--Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements (See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
--Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)
SELECT CONCAT ('INSERT INTO ',TABLE_NAME,' (name, owner_id)') AS InsertCommands
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'taverns'
UNION ALL
SELECT CONCAT ('VALUES (', (SELECT gst_first_name FROM guests WHERE guest_id = 1),', ',
(SELECT gst_last_name FROM guests WHERE guest_id = 1), ')')
UNION ALL
SELECT CONCAT ('VALUES (', (SELECT gst_first_name FROM guests WHERE guest_id = 2),', ',
(SELECT gst_last_name FROM guests WHERE guest_id = 2), ')')
UNION ALL
SELECT CONCAT ('VALUES (', (SELECT gst_first_name FROM guests WHERE guest_id = 3),', ',
(SELECT gst_last_name FROM guests WHERE guest_id = 3), ')')