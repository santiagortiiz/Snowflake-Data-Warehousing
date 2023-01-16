-- Create file format
create or replace file format garden_plants.veggies.L8_CHALLENGE_FF
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
    FIELD_DELIMITER = '\t'
;

-- Create table
create or replace table LU_SOIL_TYPE(
    SOIL_TYPE_ID number,
    SOIL_TYPE varchar(15),
    SOIL_DESCRIPTION varchar(75)
);

-- Load a file from the S3 Bucket into the new table
copy into LU_SOIL_TYPE
from @like_a_window_into_an_s3_bucket
files = ( 'LU_SOIL_TYPE.tsv')
file_format = ( format_name=L8_CHALLENGE_FF );