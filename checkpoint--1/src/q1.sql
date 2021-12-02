SELECT
(CAST (tot2 AS FLOAT)/
CAST(tot1 AS FLOAT))*100 as percent_sustained,
total_allegations,
       sustained_allegations
FROM
((SELECT COUNT(*) as tot1 FROM data_officerallegation
    JOIN data_allegation da
    on data_officerallegation.allegation_id = da.crid WHERE NOT is_officer_complaint)) as total_allegations,
((SELECT COUNT(*) as tot2
FROM data_officerallegation JOIN data_allegation da on data_officerallegation.allegation_id=da.crid
WHERE NOT is_officer_complaint AND data_officerallegation.final_finding='SU')) as sustained_allegations;

SELECT foo.number_of_allegations,foo.number_of_officers,foo.total_allegations_sustained,foo.percent_sustained FROM
(SELECT SUM(allegation_count) / COUNT (allegation_count) as number_of_allegations,
        COUNT (allegation_count) as number_of_officers,
        SUM(allegation_count) as total_allegations,
        SUM(sustained_count) as total_allegations_sustained,
        ((CAST (SUM(sustained_count) as FLOAT))/
        NULLIF((CAST (SUM(allegation_count) as FLOAT)),0))*100 as percent_sustained
FROM data_officer da WHERE da.allegation_count>0
GROUP BY allegation_count
ORDER BY allegation_count asc) as foo
WHERE percent_sustained>8 and number_of_officers>10
ORDER BY foo.percent_sustained desc;

SELECT foo.number_of_allegations,foo.number_of_officers,foo.total_allegations_sustained,foo.percent_sustained FROM
(SELECT SUM(allegation_count) / COUNT (allegation_count) as number_of_allegations,
        COUNT (allegation_count) as number_of_officers,
        SUM(allegation_count) as total_allegations,
        SUM(sustained_count) as total_allegations_sustained,
        ((CAST (SUM(sustained_count) as FLOAT))/
        NULLIF((CAST (SUM(allegation_count) as FLOAT)),0))*100 as percent_sustained
FROM data_officer da WHERE da.allegation_count>0
GROUP BY allegation_count
ORDER BY allegation_count asc) as foo
WHERE percent_sustained<8 and number_of_officers>10
ORDER BY foo.percent_sustained asc;