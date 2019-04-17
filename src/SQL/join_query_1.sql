select *
	-- langPeopGeo.PeopleID3, peops.PeopName, 
	-- langPeopGeo.ROG3, countries.Ctry, 
    -- langPeopGeo.ROL3, langs.Language,
    -- rlg.PrimaryReligion, 
    -- peopGeoRel.RLG3, peopGeoRel.PercentAdherents, peopGeoRel.PercentEvangelical, peopGeoRel.PercentPracticing,
	-- peopGeo.PopulationPercentUN, peopGeo.PopulationRounded
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
-- dddd
and langPeopGeo.PeopleID3 = peops.PeopleID3
and langPeopGeo.ROG3 = countries.ROG3
and langPeopGeo.ROL3 = langs.ROL3
and peopGeoRel.PeopleID3 = langPeopGeo.PeopleID3
and peopGeoRel.ROG3 = langPeopGeo.ROG3
and peopGeoRel.RLG3 = rlg.RLG3
and peopGeoRel.ROG3 = 'US'
and PrimaryReligion = 'Christianity'
and Language = 'English'
and peops.PeopName = 'African-Americans'   -- Error Code: 1052. Column 'PeopName' in where clause is ambiguous
order by peopGeo.PopulationPercentUN desc

