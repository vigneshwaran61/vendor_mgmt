-- Create table
create table SA_USER_SESSION_LOCK
(
  USER_ID           VARCHAR2(15) not null,
  PROGRAM_ID        VARCHAR2(15),
  LOCKING_DATE      DATE not null,
  REF_TYPE          VARCHAR2(15),
  REF_NUMBER        VARCHAR2(15),
  REMARKS           VARCHAR2(100),
  ORACLE_SESSION_ID NUMBER not null
);
-- Create/Recreate indexes 
create index IN_USL_OSI on SA_USER_SESSION_LOCK (ORACLE_SESSION_ID);
create index IN_USL_PI on SA_USER_SESSION_LOCK (PROGRAM_ID);
create index IN_USL_UI on SA_USER_SESSION_LOCK (USER_ID);


insert into MMFDBA.SA_USER_SESSION_LOCK (USER_ID, PROGRAM_ID, LOCKING_DATE, REF_TYPE, REF_NUMBER, REMARKS, ORACLE_SESSION_ID)
values ('23153816', 'HANDHELD0001', to_date('05-04-2026', 'dd-mm-yyyy'), 'Receipt_No', '', 'PCV', 133265354);

insert into MMFDBA.SA_USER_SESSION_LOCK (USER_ID, PROGRAM_ID, LOCKING_DATE, REF_TYPE, REF_NUMBER, REMARKS, ORACLE_SESSION_ID)
values ('27059130', 'CNCLTXN00002', to_date('05-04-2026 21:23:31', 'dd-mm-yyyy hh24:mi:ss'), 'CONTRACT', '8313630', 'Settlement Working', 133265355);




CREATE OR REPLACE PROCEDURE USP_GET_REF_SES_LOCK_DTL(RefID IN varchar2,
                                                     v_out OUT SYS_REFCURSOR) AS
BEGIN
  OPEN v_out FOR
    SELECT * FROM MMFDBA.SA_USER_SESSION_LOCK L WHERE L.REF_NUMBER = RefID;
END USP_GET_REF_SES_LOCK_DTL;


CREATE OR REPLACE PROCEDURE USP_GET_USER_SES_LOCK_DTL(UserID IN varchar2,
                                                      v_out  OUT SYS_REFCURSOR) AS
BEGIN
  OPEN v_out FOR
    SELECT * FROM MMFDBA.SA_USER_SESSION_LOCK L WHERE L.USER_ID = UserID;
END USP_GET_USER_SES_LOCK_DTL;



CREATE OR REPLACE PROCEDURE DELETE_USER_SES_LOCK(p_sesid  IN VARCHAR2,
                                                 p_userid IN VARCHAR2) IS
BEGIN

  DELETE FROM SA_USER_SESSION_LOCK
   WHERE ORACLE_SESSION_ID = p_sesid
     AND USER_ID = p_userid;

  COMMIT;

END DELETE_USER_SES_LOCK;
