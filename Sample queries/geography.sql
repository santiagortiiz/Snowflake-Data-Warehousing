select $1:sequence_1 as sequence_1,
    $1:trail_name as trail_name,
    $1:latitude as latitude,
    $1:longitude as longitude,
    $1:sequence_2 as sequence_2,
    $1:elevation as elevation
from @trails_parquet
(file_format => FF_PARQUET)
order by sequence_1;

--Nicely formatted trail data
select
    $1:sequence_1 as point_id,
    $1:trail_name::varchar as trail_name,
    $1:latitude::number(11,8) as lng,
    $1:longitude::number(11,8) as lat
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

--Using concatenate to prepare the data for plotting on a map
create or replace view cherry_creek_trail as
select
    $1:sequence_1 as point_id,
    $1:trail_name::varchar as trail_name,
    $1:latitude::number(11,8) as lng,
    $1:longitude::number(11,8) as lat,
    lng||' '||lat as coord_pair
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

--Using concatenate to prepare the data for plotting on a map
select top 100
    lng||' '||lat as coord_pair
    ,'POINT('||coord_pair||')' as trail_point
from cherry_creek_trail;

create or replace view cherry_creek_trail as
select
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng,
 $1:longitude::number(11,8) as lat,
 lng||' '||lat as coord_pair
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

-- Let's Collapse Sets Of Coordinates into Linestrings!
select
    'LINESTRING('||
    listagg(coord_pair, ',')
    within group (order by point_id)
    ||')' as my_linestring
from cherry_creek_trail
where point_id <= 10
group by trail_name;

select
    'LINESTRING('||
    listagg(coord_pair, ',')
    within group (order by point_id)
    ||')' as my_linestring
from cherry_creek_trail
group by trail_name;

--Remember this code?
select
    'LINESTRING('||
    listagg(coord_pair, ',')
    within group (order by point_id)
    ||')' as my_linestring
    ,st_length(my_linestring) as length_of_trail --this line is new! but it won't work!
from cherry_creek_trail
group by trail_name;

-- TO_GEOGRAPHY function
select feature_name,
    st_length(to_geography(geometry)) as trail_length
from denver_area_trails;

select
    'LINESTRING('||
    listagg(coord_pair, ',')
    within group (order by point_id)
    ||')' as my_linestring
    ,st_length(TO_GEOGRAPHY(my_linestring)) as length_of_trail
from cherry_creek_trail
group by trail_name;

-- Calculate the Lengths for the Other Trails
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
