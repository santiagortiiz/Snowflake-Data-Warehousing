
select * from directory(@uni_klaus_clothing);
select * from sweatsuits;

-- Join directory data with internal table data
select color_or_style,
    direct_url,
    price,
    size as image_size,
    last_modified as image_last_modified
from sweatsuits s
join directory(@uni_klaus_clothing) d
on d.relative_path = SUBSTR(s.direct_url, 54, 50);

-- 3 way join - internal table, directory table, and view based on external data
select color_or_style
, direct_url
, price
, size as image_size
, last_modified as image_last_modified
, sizes_available
from sweatsuits
join directory(@uni_klaus_clothing)
on relative_path = SUBSTR(direct_url,54,50)
cross join sweatsuit_sizes;