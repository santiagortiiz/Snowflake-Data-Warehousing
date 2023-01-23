-- REPLACE function knows that if you don't tell it what you want to replace the CRLF with,
-- it should replace it with nothing.
SELECT REPLACE ($1, chr(13)||chr(10)) as sizes_available
FROM @uni_klaus_zmd/sweatsuit_sizes.txt
(file_format => zmd_file_format_1)