-- EXAMPLE

-- Create a role to contain the Snowpipe privileges
use role securityadmin;

create or replace role snowpipe1;

-- Grant the required privileges on the database objects
grant usage on database snowpipe_db to role snowpipe1;

grant usage on schema snowpipe_db.public to role snowpipe1;

grant insert, select on snowpipe_db.public.mytable to role snowpipe1;

grant usage on stage snowpipe_db.public.mystage to role snowpipe1;

-- Grant the OWNERSHIP privilege on the pipe object
grant ownership on pipe snowpipe_db.public.mypipe to role snowpipe1;

-- Grant the role to a user
grant role snowpipe1 to user jsmith;

-- Set the role as the default role for the user
alter user jsmith set default_role = snowpipe1;