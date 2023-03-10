-- File formats come in 6 flavors - CSV, JSON, XML, PARQUET, ORC, & AVRO

-- Warehousing

SHOW FILE FORMATS IN ACCOUNT;

create file format garden_plants.veggies.PIPECOLSEP_ONEHEADROW
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '|' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
;

create file format garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
;

create or replace file format garden_plants.veggies.L8_CHALLENGE_FF
    TYPE = 'CSV'
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    FIELD_DELIMITER = '\t'
;

DROP FILE FORMAT garden_plants.veggies.PIPECOLSEP_ONEHEADROW;

-- XML with header
CREATE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.XML_FILE_FORMAT
TYPE = 'XML'
STRIP_OUTER_ELEMENT = FALSE
;

-- XML with no header
CREATE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.XML_FILE_FORMAT
TYPE = 'XML'
;

-- MODIFY File Format for XML Data by Changing Config
CREATE OR REPLACE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.XML_FILE_FORMAT
TYPE = 'XML'
COMPRESSION = 'AUTO'
PRESERVE_SPACE = FALSE
STRIP_OUTER_ELEMENT = TRUE
DISABLE_SNOWFLAKE_DATA = FALSE
DISABLE_AUTO_CONVERT = FALSE
IGNORE_UTF8_ERRORS = FALSE;

-- Create File Format for JSON Data
CREATE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.JSON_FILE_FORMAT
TYPE = 'JSON'
COMPRESSION = 'AUTO'
ENABLE_OCTAL = FALSE
ALLOW_DUPLICATE = FALSE
STRIP_OUTER_ARRAY = TRUE
STRIP_NULL_VALUES = FALSE
IGNORE_UTF8_ERRORS = FALSE;

-- Twitter
CREATE FILE FORMAT SOCIAL_MEDIA_FLOODGATES.PUBLIC.JSON_FILE_FORMAT
TYPE = 'JSON'
COMPRESSION = 'AUTO'
ENABLE_OCTAL = FALSE
ALLOW_DUPLICATE = FALSE
STRIP_OUTER_ARRAY = TRUE
STRIP_NULL_VALUES = FALSE
IGNORE_UTF8_ERRORS = FALSE;

-- Data Lakes

-- Exploratory file format
create file format zmd_file_format_1
RECORD_DELIMITER = '^';

-- Best for product coordination suggestions file
create or replace file format zmd_file_format_1
RECORD_DELIMITER = ';';

create file format zmd_file_format_2
FIELD_DELIMITER = '^';
