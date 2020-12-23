# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "model selection criterion added")

# commit changes including _site.yml (locally) and rebuild site
wflow_publish(c("analysis/*Rmd"), message = "XXX", republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here(
  "analysis",
  c(
    "index.Rmd",
    "config_dependencies.Rmd",
    "config_parameterization_local.Rmd",
    "eMLR_GLODAPv2_2020_subsetting.Rmd",
    "eMLR_data_preparation.Rmd",
    "eMLR_assumption_testing.Rmd",
    "eMLR_model_fitting.Rmd",
    "mapping_predictor_preparation.Rmd",
    "mapping_cant.Rmd",
    "mapping_target_variable.Rmd",
    "analysis_this_study_vs_Gruber_2019.Rmd",
    "analysis_this_study.Rmd"
  )
),
message = "rebuild before sensitivity test",
republish = TRUE)


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
