-- To remove a row you do not want in the table
delete from root_depth
where root_depth_id = 9;

DELETE FROM vegetable_details
WHERE "Plant Name"='Spinach'
AND "Rooting Depth"='D';

--To remove all the rows and start over
truncate table root_depth;
TRUNCATE TABLE GARDEN_PLANTS.VEGGIES.VEGETABLE_DETAILS;