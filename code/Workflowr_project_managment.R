# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "offset map canyon-B")

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
    "mapping_cant_mod_truth.Rmd",
    "analysis_budgets.Rmd",
    "analysis_column_inventory.Rmd",
    "analysis_zonal_sections.Rmd",
    "analysis_slab_inventory.Rmd",
    "analysis_MLR_performance.Rmd"
  )
),
message = "optional source of local params fully implemented",
republish = TRUE)


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller


# Running code manually

library(rmarkdown)

files <- c(
  "eMLR_GLODAPv2_2020_subsetting.Rmd",
  "eMLR_data_preparation.Rmd",
  "eMLR_assumption_testing.Rmd",
  "eMLR_model_fitting.Rmd",
  "mapping_predictor_preparation.Rmd",
  "mapping_cant.Rmd",
  "mapping_cant_mod_truth.Rmd",
  "analysis_budgets.Rmd",
  "analysis_column_inventory.Rmd",
  "analysis_zonal_sections.Rmd",
  "analysis_slab_inventory.Rmd",
  "analysis_MLR_performance.Rmd"
)

Version_IDs <- list.files(
  path = "/nfs/kryo/work/jenmueller/emlr_cant/observations",
  pattern = "v_1")


for (i_Version_IDs in Version_IDs) {
  for (i_files in files) {

    # i_Version_IDs <- Version_IDs[1]
    # i_files <- files[1]

    print(i_Version_IDs)
    print(i_files)

    render(
      input = here::here("analysis", i_files),
      output_dir = paste0("/nfs/kryo/work/jenmueller/emlr_cant/observations/",
                          i_Version_IDs,
                          "/website"),
      output_format = html_document(
        code_folding = "hide",
        theme = "flatly",
        highlight = "textmate"
      ),
      params = list(Version_ID = i_Version_IDs),
      quiet = TRUE
    )

    rm(list=setdiff(ls(),
                    c("i_Version_IDs", "Version_IDs",
                      "i_files", "files")))
  }
}

