-- Creating an inital table that will contain all the data
-- The date format is currently 'dd-mm-yyyy'. SQL requires date
-- data types to be in 'yyyy-mm-dd' format. 
-- This will need to be corrected.

CREATE TABLE Mass_Shootings (
	date text,
	City VARCHAR(50),
	state VARCHAR(50),
	Dead smallint,
	Injured smallint,
	Total smallint,
	Description text
)
