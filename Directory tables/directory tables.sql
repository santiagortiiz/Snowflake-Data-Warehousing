-- Used for Unstructured data
create stage UNI_KLAUS_CLOTHING
    url = 's3://uni-klaus/clothing';

list @UNI_KLAUS_CLOTHING

--Directory Tables
select * from directory(@uni_klaus_clothing);

-- Oh Yeah! We have to turn them on, first
alter stage uni_klaus_clothing
set directory = (enable = true);

--Now?
select * from directory(@uni_klaus_clothing);

--Oh Yeah! Then we have to refresh the directory table!
alter stage uni_klaus_clothing refresh;

--Now?
select * from directory(@uni_klaus_clothing);

-- Functions on directory tables
-- testing UPPER and REPLACE functions on directory table
select UPPER(RELATIVE_PATH) as uppercase_filename
, REPLACE(uppercase_filename,'/') as no_slash_filename
, REPLACE(no_slash_filename,'_',' ') as no_underscores_filename
, REPLACE(no_underscores_filename,'.PNG') as just_words_filename
from directory(@uni_klaus_clothing);

-- nest 4 statements into 3 statements
select REPLACE(UPPER(RELATIVE_PATH), '/') as no_slash_filename
, REPLACE(no_slash_filename,'_',' ') as no_underscores_filename
, REPLACE(no_underscores_filename,'.PNG') as just_words_filename
from directory(@uni_klaus_clothing);

-- All at once
select REPLACE(REPLACE(REPLACE(UPPER(RELATIVE_PATH), '/'), '_', ' '), '.PNG') AS product_name
from directory(@uni_klaus_clothing);