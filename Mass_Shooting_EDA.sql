/*	The U.S. statute (Investigative Assistance for Violent Crimes Act
	of 2012) defines a “mass killing” as “3 or more killings in a 
	single incident.” We Will Define a Mass Shooting As A Public 
	Shooting With 3 Or More Fatalities.		
*/


Delete from 
	msusa
where 
	dead <3 ;




-- 10 Deadliest Mass Shootings
SELECT 
	* 
FROM 
	msusa
ORDER BY 
	dead desc
limit 
	10;




-- Deadliest Shootings For Each State (By Fatalities)
DROP VIEW IF EXISTS DEADLIEST_SHOOTINGS_SETUP;
CREATE VIEW DEADLIEST_SHOOTINGS_SETUP AS
	SELECT 
		t.state,
		t.fatalities,
		m.injured AS injuries,
		m.total AS casualties,
		m.date,
		m.description
	FROM (
		SELECT 
			state,
			MAX(dead) AS fatalities
		FROM msusa m
		GROUP BY state) t
	JOIN msusa m ON 
		m.state = t.state AND 
		t.fatalities = m.dead;

/*	Some States Have Multiple Shootings With The Same Amount Of Fatalities
	The Repeated State With Less Casualties Will Be Deleted. (If 
	Fatalities, Injuries, And Casualties Are Equal, Row Will Be Kept) */

DROP VIEW IF EXISTS DEADLIEST_SHOOTINGS;
CREATE VIEW DEADLIEST_SHOOTINGS AS
	Select 
		z.state,
		s.fatalities,
		s.injuries,
		z.casualties,
		s.date,
		s.description
	From (
		SELECT 
			state,
			MAX(Casualties) AS Casualties
		FROM DEADLIEST_SHOOTINGS_SETUP s  
		GROUP BY state
		) z
	JOIN DEADLIEST_SHOOTINGS_SETUP s ON 
		s.state = z.state AND 
		s.casualties = z.casualties
	ORDER BY fatalities DESC;

Select * FROM DEADLIEST_SHOOTINGS;




-- Total Number Of Mass Shootings Per State 
-- Median And Average Number Of Casualties Per Shooting
select 
	state,
	COUNT(state) as Num_Of_Shootings, 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total) AS median_CAS,
	ROUND(AVG(total),2) as AVG_casualties
from 
	msusa
group by 
	state 
order by 
	Num_of_shootings desc;




-- Number Of Shootings in 2022
-- AND AVG Shootings Per Day in 2022
select 
	Count(*) as Total_2022_Shootings,
	ROUND((CAST(Count(*) as numeric)/365),2) as AVG_Shootings_Per_Day
from 
	msusa
where 
	date between '2022-01-01' and '2022-12-31';




-- Percent Of Total Shootings Per State Between 1990-2022
Select 
	state,
	ROUND((cast(COUNT(*) as numeric)/405)*100,2) as Perct_of_Shootings 
from 
	msusa
group by 
	state
order by 
	Perct_of_Shootings desc;




-- Total Deaths From Mass Shootings since 1990
select 
	sum(dead) as Total_Fatalities,
	sum(injured) as Total_injured,
	sum(total) as Total_casualties
from msusa;




-- Deadliest Day
select * 
from msusa
where dead = (
	select 
		MAX(dead)
	from 
		msusa);
	
	


-- Average Deaths Per Year Between 2020 AND 2022
select 
	ROUND(SUM(dead)/3,2) as Deaths_Per_Year_Since_2020 
from 
	msusa
where 
	date between '2020-01-01' and '2023-01-01';
 



-- Highest Rate of Mass ShootingsCites Per Year By State
-- Over Previous Decade (2012-2022)
Select 
	state,
	ROUND(SUM(dead)/10,2) as AVG_Deaths_Per_Year,
	ROUND(SUM(injured)/10,2) as AVG_injured_per_year,
	ROUND(SUM(total)/10,2) as AVG_Casualties_Per_Year,
	ROUND((Count(*)/10.0),1) as AVG_Number_Shootings_per_year
from 
	msusa
where 
	date between '2012-01-01' and '2023-01-01'
group by 
	state
order by 
	AVG_number_shootings_per_year desc;




-- Top 25 Highest Rate of Mass ShootingsCites Per Year By City
-- Over Previous Decade (2012-2022)
Select 
	state,
	city,
	ROUND((Count (*)/10.00),3) as AVG_Number_Shootings_Per_Year,
	ROUND(SUM(dead)/10,3) as AVG_Deaths_Per_Year,
	ROUND(SUM(injured)/10,3) as AVG_injured_per_year,
	ROUND(SUM(total)/10,3) as AVG_Casualties_Per_Year
from 
	msusa
where 
	date between '2012-01-01' and '2023-01-01'
group by 
	city,
	state
order by 
	AVG_number_shootings_per_Year desc
limit 
	25;




-- National Numbers
Select 
	ROUND(SUM(dead)/33,2) as AVG_Deaths_Per_Year,
	ROUND(SUM(injured)/33,2) as AVG_injured_per_year,
	ROUND(SUM(total)/33,2) as AVG_Casualties_Per_Year,
	ROUND((Count (*)/33.00),2) as AVG_Number_Shootings_Per_Year
from 
	msusa;




-- National Numbers 1990-2011
Select 
	ROUND(SUM(dead)/21,2) as AVG_Deaths_Per_Year,
	ROUND(SUM(injured)/21,2) as AVG_injured_per_year,
	ROUND(SUM(total)/21,2) as AVG_Casualties_Per_Year,
	ROUND((Count (*)/21.00),2) as AVG_Number_Shootings_Per_Year
from 
	msusa
where 
	date between '1990-01-01' and '2011-12-31';




-- National Numbers 2012-2022
Select 
	(SUM(dead)/10,2) as AVG_Deaths_Per_Year,
	ROUND(SUM(injured)/10,2) as AVG_injured_per_year,
	ROUND(SUM(total)/10,2) as AVG_Casualties_Per_Year,
	ROUND((Count (*)/10.00),2) as AVG_Number_Shootings_Per_Year
from 
	msusa
where 
	date between '2012-01-01' and '2023-01-01';































