SHOW FILE FORMATS IN ACCOUNT;

create file format garden_plants.veggies.PIPECOLSEP_ONEHEADROW
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '|' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
;

create file format garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
;

create or replace file format garden_plants.veggies.L8_CHALLENGE_FF
    TYPE = 'CSV'
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    FIELD_DELIMITER = '\t'
;

DROP FILE FORMAT garden_plants.veggies.PIPECOLSEP_ONEHEADROW;