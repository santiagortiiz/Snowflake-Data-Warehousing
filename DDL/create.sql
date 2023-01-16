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
