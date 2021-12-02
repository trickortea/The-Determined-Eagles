SELECT percent_sustained,
       rank_description
       FROM
(SELECT
SUM(allegation_count) / COUNT (allegation_count) as number_of_alligations,
        COUNT (allegation_count) as number_of_officers,
        SUM(allegation_count) as total_allegations,
        SUM(sustained_count) as total_allegations_sustained,
        ((CAST (SUM(sustained_count) as FLOAT))/
        NULLIF((CAST (SUM(allegation_count) as FLOAT)),0))*100 as percent_sustained,
       rank_id
FROM data_officerrank
JOIN data_officer on data_officerrank.officer_id=data_officer.id
GROUP BY rank_id) as temp
INNER JOIN data_policerank on temp.rank_id=data_policerank.id
WHERE number_of_officers>100
ORDER BY percent_sustained desc;
