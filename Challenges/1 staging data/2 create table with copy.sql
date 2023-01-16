-- Create Table
create or replace table GARDEN_PLANTS.VEGGIES.VEGETABLE_DETAILS_PLANT_HEIGHT (
    plant_name text(18),
    UOM text(1),
    Low_End_of_Range number(2),
    High_End_of_Range number(2)
);

-- Copy Into
copy into VEGETABLE_DETAILS_PLANT_HEIGHT
from @like_a_window_into_an_s3_bucket
files = ( 'veg_plant_height.csv')
file_format = ( format_name=COMMASEP_DBLQUOT_ONEHEADROW );

-- Validation
SELECT *
FROM VEGETABLE_DETAILS_PLANT_HEIGHT;