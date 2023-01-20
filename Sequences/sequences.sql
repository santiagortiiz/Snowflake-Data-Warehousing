create sequence SEQ_AUTHOR_UID
    start = 1
    increment = 1
    comment = 'Use this to fill in AUTHOR_ID';

-- See how the nextval function works
SELECT SEQ_AUTHOR_UID.nextval;

CREATE OR REPLACE SEQUENCE "LIBRARY_CARD_CATALOG"."PUBLIC"."SEQ_BOOK_UID"
START 1
INCREMENT 1
COMMENT = 'Use this to fill in the BOOK_UID everytime you add a row';

SHOW sequences;