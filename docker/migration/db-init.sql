CREATE TABLE employees (
first_name varchar(25),
last_name  varchar(25),
department varchar(15),
email  varchar(50)
);

INSERT INTO employees (first_name, last_name, department, email) 
VALUES ('Person', 'Personsen', 'IT', 'Person@mail.com');

CREATE TABLE county_data(
   COUNTY      VARCHAR(10) NOT NULL
  ,HD_CODE     VARCHAR(4) NOT NULL
  ,HD_NAME     VARCHAR(17) NOT NULL
  ,CD_CODE     VARCHAR(8) NOT NULL
  ,CD_NAME     VARCHAR(31) NOT NULL
  ,PARTY       VARCHAR(32) NOT NULL
  ,SYSDATE     VARCHAR(32) NOT NULL 
  ,COUNTVID    INTEGER  NOT NULL
);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('CLACKAMAS','SR48','House District 48','3rd Cong','US Congressional District 3','Democrat','11/03/2017',143);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('WASHINGTON','SR28','House District 28','1st Cong','US Congressional District 1','Democrat','11/03/2017',16012);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('WASHINGTON','SR26','House District 26','1st Cong','US Congressional District 1','Nonaffiliated','11/03/2017',9722);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('COLUMBIA','SR31','House District 31','1st Cong','US Congressional District 1','Working Families Party of Oregon','11/03/2017',130);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('LANE','SR14','House District 14','4th Cong','US Congressional District 4','Nonaffiliated','11/03/2017',13853);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('JEFFERSON','SR59','House District 59','2nd Cong','US Congressional District 2','Pacific Green','11/03/2017',31);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('LINCOLN','SR09','House District 09','5th Cong','US Congressional District 5','Democrat','11/03/2017',369);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('JOSEPHINE','SR03','House District 03','4th Cong','US Congressional District 4','Working Families Party of Oregon','11/03/2017',35);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('MULTNOMAH','SR46','House District 46','3rd Cong','US Congressional District 3','Democrat','11/03/2017',25524);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('DESCHUTES','SR55','House District 55','2nd Cong','US Congressional District 2','Working Families Party of Oregon','11/03/2017',32);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('BENTON','SR15','House District 15','4th Cong','US Congressional District 4','Libertarian','11/03/2017',7);
INSERT INTO county_data(COUNTY,HD_CODE,HD_NAME,CD_CODE,CD_NAME,PARTY,SYSDATE,COUNTVID) VALUES ('WASCO','SR59','House District 59','2nd Cong','US Congressional District 2','Pacific Green','11/03/2017',42);

CREATE TABLE Users (
Id INT AUTO_INCREMENT PRIMARY KEY,
FirstName varchar(25),
LastName  varchar(25),
Department varchar(15),
Email  varchar(50),
FavoriteGenre varchar(50)
);

INSERT INTO Users (FirstName, LastName, Department, Email, FavoriteGenre) VALUES ('Pary', 'Peersen', 'IT', 'Person@mail.com', 'Rock');
INSERT INTO Users (FirstName, LastName, Department, Email, FavoriteGenre) VALUES ('Amy', 'Smith', 'News Desk', 'a@mail.com', "Reagge");
INSERT INTO Users (FirstName, LastName, Department, Email, FavoriteGenre) VALUES ('Jose', 'Johnson', 'Music', 'j@mail.com', "Country");
INSERT INTO Users (FirstName, LastName, Department, Email, FavoriteGenre) VALUES ('Rob', 'Jerbarkle', 'Internal', 'jn@mail.com', "Pop");

create user 'root'@'10.0.2.2' identified by 'supersecret';
grant all privileges on *.* to 'root'@'10.0.2.2' with grant option;
flush privileges;