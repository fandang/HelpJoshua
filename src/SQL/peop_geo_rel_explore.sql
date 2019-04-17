select * from tblLnkPEOtoGEO peopGeo where ROG3 = 'UStblPEO3PeopleGroups'

    -- peopGeoRel.PercentAdherents
    
select
countries.ROG3 as Countries_ROG3, Ctry as Countries_Country, peopGroups.PeopleID3 as PeopleGroupsPeopleID3, PeopName as PeopleGroupsPeopleName, rlgn.RLG3 as Religions_RLG3, rlgn.PrimaryReligion as PrimaryReligion_RLG3, Version, peopGeoRel.PercentAdherents as PeopGeoRel_PercentAdherents
from tblGEO3Countries countries, tblLnkPEOtoGEOReligions peopGeoRel, tblPEO3PeopleGroups peopGroups, tblRLG3Religions rlgn
where countries.ROG3 = peopGeoRel.ROG3
and peopGeoRel.PeopleID3 = peopGroups.PeopleID3
and rlgn.RLG3 = peopGeoRel.RLG3
and peopGeoRel.Version = (
	select max(Version) from tblLnkPEOtoGEOReligions peopGeoRelINNER 
    where peopGeoRelINNER.PeopleID3 = peopGeoRel.PeopleID3 
    and peopGeoRelINNER.ROG3 = peopGeoRel.ROG3 
    and peopGeoRelINNER.RLG3 = peopGeoRel.RLG3
)
and countries.ROG3 = 'US'
-- and rlgn.PrimaryReligion = 'Christianity'
and PeopName = 'Americans, U.S.'
order by PeopName
