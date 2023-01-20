-- Define information about a location where some files are already staged
create stage garden_plants.veggies.like_a_window_into_an_s3_bucket
url = 's3://uni-lab-files';

-- List items in the stage
list @like_a_window_into_an_s3_bucket;
list @like_a_window_into_an_s3_bucket/<file_name>;

-- Load a File from the S3 Bucket into the New Table
copy into my_table_name
from @like_a_window_into_an_s3_bucket
files = ( 'IF_I_HAD_A_FILE_LIKE_THIS.txt')
file_format = ( format_name='EXAMPLE_FILEFORMAT' );

-- Ingest data from AWS/S3
create or replace table vegetable_details_soil_type (
    plant_name varchar(25),
    soil_type number(1,0)
);

copy into vegetable_details_soil_type
from @like_a_window_into_an_s3_bucket
files = ( 'VEG_NAME_TO_SOIL_TYPE_PIPE.txt')
file_format = ( format_name=PIPECOLSEP_ONEHEADROW );

copy into AUTHOR_INGEST_XML
from @like_a_window_into_an_s3_bucket
files = ( 'author_with_header.xml')
file_format = ( format_name=XML_FILE_FORMAT );

-- XML
copy into AUTHOR_INGEST_XML
from @like_a_window_into_an_s3_bucket
files = ( 'author_with_header.xml')
file_format = ( format_name=XML_FILE_FORMAT );

-- JSON
copy into AUTHOR_INGEST_JSON
from @like_a_window_into_an_s3_bucket
files = ( 'author_with_header.json')
file_format = ( format_name=JSON_FILE_FORMAT );