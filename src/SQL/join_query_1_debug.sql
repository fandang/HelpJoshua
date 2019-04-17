select
	peopGeoRel.Version, countries.Ctry, 
    peopGeo.PopulationPercentUN, peopGeo.PopulationRounded,
    langPeopGeo.PeopleID3, peops.PeopName, langPeopGeo.ROG3, langPeopGeo.ROL3, langs.Language,     rlg.PrimaryReligion,      
    peopGeoRel.RLG3, 
    peopGeoRel.PercentAdherents
    -- peopGeoRel.PercentEvangelical, peopGeoRel.PercentPracticing,  
from      
	tblPEO3PeopleGroups peops, 
    tblGEO3Countries countries,  
    tblLNG3Languages langs, 
    tblRLG3Religions rlg,  
    tblLnkPEOtoGEO peopGeo,  
    tbllnkLNGtoPEOGEO langPeopGeo,      
    tblLnkPEOtoGEOReligions peopGeoRel 
where peopGeo.PeopleID3 = langPeopGeo.PeopleID3 
and peopGeo.ROG3 = langPeopGeo.ROG3
and langPeopGeo.PeopleID3 = peops.PeopleID3 
and langPeopGeo.ROG3 = countries.ROG3 
and langPeopGeo.ROL3 = langs.ROL3 
and peopGeoRel.PeopleID3 = langPeopGeo.PeopleID3 
and peopGeoRel.ROG3 = langPeopGeo.ROG3 
and peopGeoRel.RLG3 = rlg.RLG3
and peopGeoRel.Version = (
	select max(Version) from tblLnkPEOtoGEOReligions peopGeoRelINNER 
    where peopGeoRelINNER.PeopleID3 = peopGeoRel.PeopleID3 
    and peopGeoRelINNER.ROG3 = peopGeoRel.ROG3 
    and peopGeoRelINNER.RLG3 = peopGeoRel.RLG3
)
and peopGeoRel.ROG3 = 'US' and Language = 'English' -- and PrimaryReligion = 'Christianity'    -- Error Code: 1052. Column 'PeopName' in where clause is ambiguous 
-- and peops.PeopName = 'African-Americans'
and peops.PeopName = 'British'
order by peopGeo.PopulationPercentUN desc


-- SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'JOSHUA' AND COLUMN_NAME = 'Version';