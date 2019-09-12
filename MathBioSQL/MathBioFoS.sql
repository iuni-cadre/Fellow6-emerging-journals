\COPY (
select p.paper_id, p.doi, p.paper_title, p.original_venue, p.year, p.citation_count, array_agg(concat(fos.normalized_name, ' | ', fos.level, ' | ', pfos.score)) as fos
from mag_core.papers p
left outer join mag_core.paper_fields_of_study pfos on p.paper_id=pfos.paper_id
left outer join mag_core.fields_of_study fos on pfos.field_of_study_id=fos.field_of_study_id
where p.paper_id in 
(select paper_id from mag_core.papers where journal_id in ('129150467','109682412','171842551','78242885','86033158','118940690'))
group by p.paper_id, p.doi, p.paper_title, p.original_venue, p.year, p.citation_count
) to '/home/yan30/workingdir/code/FellowSupport/Fellow6-emerging-journals/MathBioSQL/MathBioFoS.csv' with csv;
