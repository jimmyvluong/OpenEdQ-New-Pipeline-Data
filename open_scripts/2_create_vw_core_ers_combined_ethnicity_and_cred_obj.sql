/*
This script creates a schema-binded view that adds on the:
1. credential objective lookup data (MS,SS,ES) from the COSAR tables
2. race/ethnicity description data
3. campus names data.
*/
CREATE OR ALTER VIEW core_ers.mat_vw_erss_combined_ethnicity_and_cred_obj
WITH SCHEMABINDING
AS
SELECT 
    erss_combined.calstateEduPersonUID,
    erss_combined.erss_year,
    erss_combined.erss_term,
    erss_combined.erss_campus,
    erss_combined.erss_birth_date,
    erss_combined.erss_sex,
    erss_combined.erss_ethnic_old,
    erss_combined.erss_cit,
    erss_combined.erss_country,
    erss_combined.erss_res,
    erss_combined.erss_res_stat,
    erss_combined.erss_inst_orig,
    erss_combined.erss_matric_per,
    erss_combined.erss_adm_basis_old,
    erss_combined.erss_enroll_stat,
    erss_combined.erss_stud_lev,
    erss_combined.erss_deg_obj,
    erss_combined.erss_conc,
    erss_combined.erss_cred_stat,
    erss_combined.erss_cred_obj,
    erss_combined.erss_deg_held,
    erss_combined.erss_stud_stand,
    erss_combined.erss_transf_gpa,
    erss_combined.erss_campus_gpa,
    erss_combined.erss_total_ue,
    erss_combined.erss_total_gpa,
    erss_combined.erss_eop_stat,
    erss_combined.erss_dss,
    erss_combined.erss_dss_prog,
    erss_combined.erss_cip,
    erss_combined.erss_cred_emph,
    erss_combined.erss_tua_ld,
    erss_combined.erss_tua_ud,
    erss_combined.erss_tua_gd,
    erss_combined.erss_hs_gpa,
    erss_combined.erss_imm_yr,
    erss_combined.erss_spec_prog,
    erss_combined.erss_start_date_CST,
    erss_combined.erss_sufw,
    erss_combined.erss_matric_type,
    erss_combined.erss_tua_pc,
    erss_combined.erss_mil_stat,
    erss_combined.erss_hl_stat,
    erss_combined.erss_hl_catg,
    erss_combined.erss_multi_race_catg,
    erss_combined.erss_ipeds_race_catg,
    erss_combined.erss_emplid,
    erss_combined.erss_major,
    erss_combined.erss_cur_mil_stat,
    erss_combined.erss_mil_dep_stat,
    erss_combined.erss_ccc_control,
    erss_combined.erss_cum_ue_campus,
    erss_combined.erss_deg_prog_del,
    erss_combined.erss_adm_basis_new,
    erss_combined.erss_add_auth,
    erss_combined.erss_ca_prom_stat,
    erss_combined.erss_ssid,
    erss_combined.erss_csuapply_id,
    vw_cred_obj_lookup.lookup_erss_cred_obj,
    vw_cred_obj_lookup.cred_obj_description,
    vw_cred_obj_lookup.code_value,
    ipeds_race_lookup.ipeds_value,
    ipeds_race_lookup.race_description
	, campus_codes_and_names.campus_name
    , campus_codes_and_names.campus_id_number
    , campus_codes_and_names.campus_letter_code
FROM core_ers.erss_combined
INNER JOIN core_ers.vw_cred_obj_lookup 
    ON erss_combined.erss_cred_obj = vw_cred_obj_lookup.lookup_erss_cred_obj
INNER JOIN core_ers.ipeds_race_lookup 
    ON erss_combined.erss_ipeds_race_catg = ipeds_race_lookup.ipeds_value
INNER JOIN core_ers.campus_codes_and_names
	ON  erss_combined.erss_campus = campus_codes_and_names.campus_code;
GO