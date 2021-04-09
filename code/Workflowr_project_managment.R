# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "included model data")

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
    "analysis_budgets.Rmd",
    "analysis_column_inventory.Rmd",
    "analysis_zonal_sections.Rmd",
    "analysis_slab_inventory.Rmd",
    "analysis_MLR_performance.Rmd"
  )
),
message = "included model data",
republish = TRUE)

wflow_publish(here::here(
  "analysis",
  c(
    "eMLR_data_preparation.Rmd"
  )
),
message = "included model data")


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
