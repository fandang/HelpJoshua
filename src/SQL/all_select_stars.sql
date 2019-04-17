-- 17 total tables

-- 5 GEO tables (these plus the 2 UN tables)
SELECT * FROM JOSHUA.tblGEO2Continents;
SELECT * FROM JOSHUA.tblGEO2Regions;
SELECT * FROM JOSHUA.tblGEO3Countries;

-- 2 Langauge tables
SELECT * FROM JOSHUA.tblLNG3Languages;
SELECT * FROM JOSHUA.tblLNG4Dialects;

select tblLNG3Languages.ROL3, Language, ROL4, Dialect from tblLNG4Dialects, tblLNG3Languages where tblLNG3Languages.ROL3 = tblLNG4Dialects.ROL3

-- 4 x-tables with lnk prefix - the 4 x-tables
SELECT * FROM JOSHUA.tbllnkLNGtoPEOGEO;


-- 4 People tables
SELECT * FROM JOSHUA.tblPEO1AffinityBlocs;
SELECT * FROM JOSHUA.tblPEO2PeopleClusters;
SELECT * FROM JOSHUA.tblPEO3PeopleGroups;
SELECT * FROM JOSHUA.tblPEO4SubGroups;

-- 2 Religion tables
SELECT * FROM JOSHUA.tblRLG3Religions;
SELECT * FROM JOSHUA.tblRLG4ReligionSubdivisions;

