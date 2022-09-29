CREATE USER c##project IDENTIFIED BY assignment;
GRANT CONNECT, RESOURCE TO c##project;
ALTER USER C##project
QUOTA 1024M ON USERS;
CONN C##project/assignment;