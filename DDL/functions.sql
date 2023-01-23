select get_ddl('view', 'DENVER_AREA_TRAILS');

CREATE OR REPLACE FUNCTION distance_to_mc(loc_lat number(38,32), loc_lng number(38,32))
    RETURNS FLOAT
    AS
    $$
        st_distance(
            st_makepoint('-104.97300245114094','39.76471253574085'),
            st_makepoint(loc_lat,loc_lng)
        )
    $$
;

-- Changing the Function to Accept a GEOGRAPHY Argument
CREATE OR REPLACE FUNCTION distance_to_mc(lat_and_lng GEOGRAPHY)
  RETURNS FLOAT
  AS
  $$
   st_distance(
        st_makepoint('-104.97300245114094','39.76471253574085')
        ,lat_and_lng
        )
  $$
;

-- Function usage
SELECT
 name
 ,cuisine
 ,distance_to_mc(coordinates) AS distance_from_melanies
 ,*
FROM  competition
ORDER by distance_from_melanies;

-- Different Options, Same Outcome!
-- Tattered Cover Bookstore McGregor Square
set tcb_lat='-104.9956203';
set tcb_lng='39.754874';

--this will run the first version of the UDF
select distance_to_mc($tcb_lat,$tcb_lng);

--this will run the second version of the UDF, bc it converts the coords
--to a geography object before passing them into the function
select distance_to_mc(st_makepoint($tcb_lat,$tcb_lng));

--this will run the second version bc the Sonra Coordinates column
-- contains geography objects already
select name
, distance_to_mc(coordinates) as distance_to_melanies
, ST_ASWKT(coordinates)
from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_SHOP
where shop='books'
and name like '%Tattered Cover%'
and addr_street like '%Wazee%';