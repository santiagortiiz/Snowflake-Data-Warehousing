-- Well, we left out an important detail.
-- You CAN put a Materialized View over an External Table,
-- even if that External Table is based on a Stage!!

-- In other words, you CAN put a Materialized View over staged data,
-- as long as you put an External Table in between them, first!

select * from cherry_creek_trail;

alter view cherry_creek_trail
rename to v_cherry_creek_trail;

create or replace external table T_CHERRY_CREEK_TRAIL(
	my_filename varchar(50) as (metadata$filename::varchar(50))
)
location= @trails_parquet
auto_refresh = true
file_format = (type = parquet);

select get_ddl('view','mels_smoothie_challenge_db.trails.v_cherry_creek_trail');

create or replace view V_CHERRY_CREEK_TRAIL(
	POINT_ID,
	TRAIL_NAME,
	LNG,
	LAT,
	COORD_PAIR
) as
select
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng,
 $1:longitude::number(11,8) as lat,
 lng||' '||lat as coord_pair
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

-- Now Let's Modify Our V_CHERRY_CREEK_TRAIL Code to Create the New Table
create or replace external table mels_smoothie_challenge_db.trails.T_CHERRY_CREEK_TRAIL(
	POINT_ID number as ($1:sequence_1::number),
	TRAIL_NAME varchar(50) as  ($1:trail_name::varchar),
	LNG number(11,8) as ($1:latitude::number(11,8)),
	LAT number(11,8) as ($1:longitude::number(11,8)),
	COORD_PAIR varchar(50) as (lng::varchar||' '||lat::varchar)
)
location= @mels_smoothie_challenge_db.trails.trails_parquet
auto_refresh = true
file_format = mels_smoothie_challenge_db.trails.ff_parquet;

select * from T_CHERRY_CREEK_TRAIL;

-- Create a secure materialized view on top of the external table
create secure materialized view SMV_CHERRY_CREEK_TRAIL
    as select * from T_CHERRY_CREEK_TRAIL;

select * from SMV_CHERRY_CREEK_TRAIL;