-- Warehousing

-- Inspection statements using pre-defined file formats

-- List items in the stage
    list @like_a_window_into_an_s3_bucket;
    list @like_a_window_into_an_s3_bucket/<file_name>;

--The data in the file, with no FILE FORMAT specified
select $1
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv;

select $1
from @uni_klaus_zmd;

--Same file but with one of the file formats we created earlier
select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW);

--Same file but with the other file format we created earlier
select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.PIPECOLSEP_ONEHEADROW );


-- Data Lakes
select $1
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_1);

select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_2);

select $1, $2
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_3);

-- Removing CRLF characters
SELECT REPLACE($1, chr(13)||chr(10)) as sizes_available
FROM @uni_klaus_zmd/sweatsuit_sizes.txt
(file_format => zmd_file_format_2)
WHERE sizes_available <> '';