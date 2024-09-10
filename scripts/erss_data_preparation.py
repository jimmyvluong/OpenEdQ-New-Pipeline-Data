# load packages

import pandas as pd

# read in data

df = pd.read_csv(
    "..\data\erss\ERSS_20213_20222_221215.csv",
    dtype={
        "erss_cred_stat": str,
        "erss_ethnic_old": str,
        "erss_cred_emph": str,
        "erss_spec_prog": str,
    },
)


# load in campus names and campus codes
df_campus_codes = pd.read_excel("..\data\campus_codes\campus_codes_and_names.xlsx")

df_2021_fall = df[
    (df["erss_year"] == 2021)
    & (df["erss_term"] == 4)
    & (df["erss_cred_stat"].isin(["4", "5", "6", "8", "V"]))
]

# load in credential objective lookup table
df_lookup = pd.read_excel("data\erss_cred_obj_lookup.xlsx")

# change to type int
df_lookup["SourceCode"] = df_lookup["SourceCode"].astype(int)

####################################################################
# left join the program type onto the main DataFrame
df_2021_combined = pd.merge(
    df_2021_fall, df_lookup, left_on="erss_cred_obj", right_on="SourceCode", how="left"
)

# left join the campus names onto the main DataFrame
df_2021_combined_names = pd.merge(
    df_2021_combined,
    df_campus_codes,
    left_on="erss_campus",
    right_on="campus_code",
    how="left",
)

####################################################################

# write to a csv file
df_2021_combined_names.to_csv("output\erss_2021_2022.csv")
