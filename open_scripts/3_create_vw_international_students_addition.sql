/*
This CTE creates a column race_desc_with_intl.

This version uses two years of profile data for AY 2021-2022 and AY 2022-2023. Jimmy has requested the non-profile data from the IR & A team.

*/

/*
drop view if exists [core_ers].[vw_international_students_addition];
go
*/
create or alter view [core_ers].[vw_international_students_addition]
as
with international_students_cte as (
select 
  *,
  /*
  This case statement re-labels Race/Ethnicity to align with IR & A dashboards, which include the category "International Student".
  One more step needs to happen to replicate the numbers: pre-filtering based on logic in the IPEDS website.
  */
  case
  ---- Non-U.S. citizen
  when
   erss_cit IN ('F','O','N')
  then 'International Student'
    else race_description
    end as race_desc_with_intl
----------------------------------------------
from core_ers.mat_vw_erss_combined_ethnicity_and_cred_obj
----------------------------------------------
)
select * from international_students_cte;
go