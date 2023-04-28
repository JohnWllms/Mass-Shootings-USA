-- This query will reformat the dates in the date column as well as
-- changing the data type to date type.
-- I have selected the other columns in the table, so that I can 
-- export the resulting query as a new CSV file. Next, a new
-- table will be made with the updated data.

select TO_DATE(date,'DD-MM-YYYY') as 
date,city,state,dead,injured,total,description 
from mass_shootings
