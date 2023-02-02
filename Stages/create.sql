create stage s3_stage
  storage_integration = s3_int
  url = 's3://epam-lab/raw-data'
  file_format = my_csv_format;

create stage UNI_KLAUS_CLOTHING
    url = 's3://uni-klaus/clothing';

create stage UNI_KLAUS_ZMD
    url = 's3://uni-klaus/zenas_metadata';

create stage UNI_KLAUS_SNEAKERS
    url = 's3://uni-klaus/sneakers';

create stage trails_parquet
    url = 's3://uni-lab-files-more/dlkw/trails_parquet';

create stage trails_geojson
    url = 's3://uni-lab-files-more/dlkw/trails_geojson';