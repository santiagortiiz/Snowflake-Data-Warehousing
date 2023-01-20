use role sysadmin;
create or replace table GARDEN_PLANTS.VEGGIES.ROOT_DEPTH (
    ROOT_DEPTH_ID number(1),
    ROOT_DEPTH_CODE text(1),
    ROOT_DEPTH_NAME text(7),
    UNIT_OF_MEASURE text(2),
    RANGE_MIN number(2),
    RANGE_MAX number(2)
);

create table vegetable_details
(
    plant_name varchar(25),
    root_depth_code varchar(1)
);

create or replace table vegetable_details_soil_type (
    plant_name varchar(25),
    soil_type number(1,0)
);

create or replace table GARDEN_PLANTS.VEGGIES.VEGETABLE_DETAILS_PLANT_HEIGHT (
    plant_name text(15),
    UOM text(1),
    Low_End_of_Range number(2),
    High_End_of_Range number(2)
);

CREATE OR REPLACE TABLE AUTHOR (
   AUTHOR_UID NUMBER
  ,FIRST_NAME VARCHAR(50)
  ,MIDDLE_NAME VARCHAR(50)
  ,LAST_NAME VARCHAR(50)
);

-- Create the book table and use the NEXTVAL as the
-- default value each time a row is added to the table
CREATE OR REPLACE TABLE BOOK (
    BOOK_UID NUMBER DEFAULT SEQ_BOOK_UID.nextval,
    TITLE VARCHAR(50),
    YEAR_PUBLISHED NUMBER(4,0)
);

-- Create an Ingestion Table for XML Data
CREATE TABLE LIBRARY_CARD_CATALOG.PUBLIC.AUTHOR_INGEST_XML
(
  "RAW_AUTHOR" VARIANT --data type for semi-structured data
);

-- Create an Ingestion Table for JSON Data
CREATE TABLE "LIBRARY_CARD_CATALOG"."PUBLIC"."AUTHOR_INGEST_JSON"
(
  "RAW_AUTHOR" VARIANT --data type for semi-structured data
);

-- Create an Ingestion Table for the NESTED JSON Data
CREATE OR REPLACE TABLE LIBRARY_CARD_CATALOG.PUBLIC.NESTED_INGEST_JSON
(
  "RAW_NESTED_BOOK" VARIANT
);

-- Twitter
CREATE TABLE SOCIAL_MEDIA_FLOODGATES.PUBLIC.TWEET_INGEST
("RAW_STATUS" VARIANT)
COMMENT = 'Bring in tweets, one row per tweet or status entity';