--Remember this code? Re-Using Earlier Code (with Geospatial function) 
select
    'LINESTRING('||
    listagg(coord_pair, ',')
    within group (order by point_id)
    ||')' as my_linestring
    ,st_length(TO_GEOGRAPHY(my_linestring)) as length_of_trail
from cherry_creek_trail
group by trail_name;

select feature_name,
    st_length(to_geography(geometry)) as trail_length
from denver_area_trails;

select get_ddl('view', 'DENVER_AREA_TRAILS');

create or replace view DENVER_AREA_TRAILS(
	FEATURE_NAME,
	FEATURE_COORDINATES,
	GEOMETRY,
    TRAIL_LENGTH,
	FEATURE_PROPERTIES,
	SPECS,
	WHOLE_OBJECT
) as
select
$1:features[0]:properties:Name::string as feature_name
,$1:features[0]:geometry:coordinates::string as feature_coordinates
,$1:features[0]:geometry::string as geometry
,st_length(to_geography(geometry)) as trail_length
,$1:features[0]:properties::string as feature_properties
,$1:crs:properties:name::string as specs
,$1 as whole_object
from @trails_geojson (file_format => ff_json);

--Create a view that will have similar columns to DENVER_AREA_TRAILS
--Even though this data started out as Parquet, and we're joining it with geoJSON data
--So let's make it look like geoJSON instead.
create view DENVER_AREA_TRAILS_2 as
select
    trail_name as feature_name
    ,'{"coordinates":['||listagg('['||lng||','||lat||']',',')||'],"type":"LineString"}' as geometry
    ,st_length(to_geography(geometry)) as trail_length
from cherry_creek_trail
group by trail_name;

select * from DENVER_AREA_TRAILS_2;

--Create a view that will have similar columns to DENVER_AREA_TRAILS
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS
union all
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS_2;

-- Analyze Melanie's competition using Sonra data
create or replace view COMPETITION as
select *
from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_AMENITY_SUSTENANCE
where
    ((amenity in ('fast_food','cafe','restaurant','juice_bar'))
    and
    (name ilike '%jamba%' or name ilike '%juice%'
     or name ilike '%superfruit%'))
 or
    (cuisine like '%smoothie%' or cuisine like '%juice%');

-- Which Competitor is Closest to Melanie's? ST_DISTANCE
SELECT
 name
 ,cuisine
 , ST_DISTANCE(
    st_makepoint('-104.97300245114094','39.76471253574085')
    , coordinates
  ) AS distance_from_melanies
 ,*
FROM  competition
ORDER by distance_from_melanies;