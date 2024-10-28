/*

*/

create or alter view [core_ers].[vw_core_enrollment_count_and_completion_rate]
as
with cred_students_code_cte as (
select 
  *,
  /*
  This case statement labels records into credential programs based on Appendix C in the ERS Operations Manual.
  */
  case 
  ---- C-3: STUDENTS IN AN INTEGRATED TEACHER PREPARATION 
  when
	erss_stud_lev in (3,4)
	and erss_cred_stat in ('5', '6')
	and erss_stud_stand in ('B')
	and code_value in ('SS','MS','ES')
  then 'Preliminary Credential: Integrated'
  ---- C-4: UNDERGRADUATE STUDENTS IN A REGULAR CREDENTIAL PROGRAM
  when
	erss_stud_lev in (3,4)
	and erss_cred_stat in ('5', '6')
	and erss_stud_stand in ('5')
	and code_value in ('SS','MS','ES')
  then 'Preliminary Credential: Regular Undergraduate'
  ---- C-5 Part 1: POSTBACCALAUREATE OR GRADUATE STUDENTS IN A REGULAR CREDENTIAL PROGRAM
  when 
	erss_stud_lev = 5
	and erss_cred_stat in ('5', '6', 'V', 'H', 'I', 'J', 'K')
	and erss_stud_stand in ('C', '5', '1', '2', '3', '6', '7', '8')
	and code_value in ('SS','MS','ES')
  then 'Preliminary Credential: Regular Postbacc or Graduate' 
  ---- C-5 Part 2: POSTBACCALAUREATE OR GRADUATE STUDENTS IN A CLEAR CREDENTIAL PROGRAM
  when 
	erss_stud_lev = 5
	and erss_cred_stat in ('4')
	and erss_stud_stand in ('C', '5', '1', '2', '3', '6', '7', '8')
	and code_value in ('SS','MS','ES')
  then 'Clear Credential' 
  ---- C-6: STUDENTS IN AN INTERNSHIP PROGRAM
  when
	erss_stud_lev = 5
	and erss_cred_stat in ('8')
	and erss_stud_stand in ('5', '1', '2', '3', '6', '7', '8')
	and code_value in ('SS','MS','ES')
	-- or erss_cred_obj in (501,802,804))
  then 'Preliminary Credential: Internship'
	else 'Other'
	end as Credential_Type
from [core_ers].[vw_enrollment_status_addition]
)
select * from cred_students_code_cte
where erss_term = 4 
and Credential_Type != 'Other' ;
go
