SELECT foo.discipline_count,foo.misconduct_allegations_per_officer,foo.number_of_officers,foo.percent_sustained FROM
(SELECT SUM(allegation_count) / COUNT (allegation_count) as number_of_allegations,
        COUNT (discipline_count) as number_of_officers,
       (CAST(SUM(allegation_count)as FLOAT))/(CAST(COUNT(discipline_count) as FLOAT)) as misconduct_allegations_per_officer,
        ((CAST (SUM(sustained_count) as FLOAT))/
        NULLIF((CAST (SUM(allegation_count) as FLOAT)),0))*100 as percent_sustained,
        discipline_count
FROM data_officer da WHERE da.allegation_count>0
GROUP BY discipline_count
ORDER BY discipline_count asc) as foo
WHERE percent_sustained>5 and number_of_officers>10
ORDER BY foo.percent_sustained desc;

