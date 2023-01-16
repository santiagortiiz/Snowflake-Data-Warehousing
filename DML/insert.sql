USE WAREHOUSE COMPUTE_WH;

INSERT INTO ROOT_DEPTH (
	ROOT_DEPTH_ID ,
	ROOT_DEPTH_CODE ,
	ROOT_DEPTH_NAME ,
	UNIT_OF_MEASURE ,
	RANGE_MIN ,
	RANGE_MAX
)

VALUES
(
    1,
    'S',
    'Shallow',
    'cm',
    30,
    45
)
;

--To add more than one row at a time
insert into root_depth (root_depth_id, root_depth_code
                        , root_depth_name, unit_of_measure
                        , range_min, range_max)
values
 (5,'X','short','in',66,77)
,(8,'Y','tall','cm',98,99)
;