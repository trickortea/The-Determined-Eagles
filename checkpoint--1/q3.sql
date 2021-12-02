SELECT
CAST(SUM(CASE WHEN final_finding='SU' THEN 1 ELSE 0 END) AS FLOAT) /
CAST(SUM(CASE WHEN final_finding='SU' THEN 1 ELSE 0 END) +
      SUM(CASE WHEN final_finding='NS' THEN 1 ELSE 0 END)AS FLOAT)*100
as percentage_sustained_unknown_unincluded,
CAST(SUM(CASE WHEN final_finding='SU' THEN 1 ELSE 0 END)AS FLOAT)/CAST(COUNT(*)AS FLOAT) *100 as percentage_sustained_over_total_allegations,
category
FROM(
(SELECT * FROM data_officerallegation JOIN data_allegation da on data_officerallegation.allegation_id=da.crid
WHERE NOT is_officer_complaint) as alleg
JOIN data_allegationcategory dac on alleg.allegation_category_id=dac.id)
GROUP BY category
ORDER BY percentage_sustained_over_total_allegations desc
;

SELECT
CAST(SUM(CASE WHEN final_finding='SU' THEN 1 ELSE 0 END)AS FLOAT)/CAST(COUNT(*)AS FLOAT) *100 as percentage_sustained_over_total_allegations,
category,
      CAST( COUNT(*)as FLOAT) / CAST(235263 as FLOAT) *100 as percentage_of_allegations
FROM(
(SELECT * FROM data_officerallegation JOIN data_allegation da on data_officerallegation.allegation_id=da.crid
WHERE NOT is_officer_complaint) as alleg
JOIN data_allegationcategory dac on alleg.allegation_category_id=dac.id)
GROUP BY category
ORDER BY percentage_of_allegations desc
;
