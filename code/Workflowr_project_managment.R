# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "calculated combined cstar contribution")

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
    "mapping_dcant_eMLR.Rmd",
    "mapping_dcant_mod_truth.Rmd",
    "mapping_target_variable.Rmd",
    "analysis_budgets.Rmd",
    "analysis_column_inventory.Rmd",
    "analysis_zonal_sections.Rmd",
    "analysis_slab_inventory.Rmd",
    "analysis_MLR_performance.Rmd",
    "analysis_anomalous_changes.Rmd",
    "tracers_GLODAPv2_2021.Rmd"
  )
),
message = "rerun era2",
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
  "mapping_dcant_eMLR.Rmd",
  "mapping_dcant_mod_truth.Rmd",
  "analysis_budgets.Rmd",
  "analysis_column_inventory.Rmd",
  "analysis_zonal_sections.Rmd",
  "analysis_slab_inventory.Rmd",
  "analysis_MLR_performance.Rmd",
  "analysis_anomalous_changes.Rmd",
  "tracers_GLODAPv2_2021.Rmd"
)

Version_IDs_1 <- list.files(
  path = "/nfs/kryo/work/jenmueller/emlr_cant/observations",
  pattern = "v_11")#[c(4)]

Version_IDs_2 <- list.files(
  path = "/nfs/kryo/work/jenmueller/emlr_cant/observations",
  pattern = "v_21")#[c(4)]

Version_IDs_3 <- list.files(
  path = "/nfs/kryo/work/jenmueller/emlr_cant/observations",
  pattern = "v_31")#[c(4,2)]

Version_IDs <- c(
  Version_IDs_1,
  Version_IDs_2,
  Version_IDs_3
  )


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

### concept code

Dear John,

sorry for the late reply to this issue. I had to focus on some scientific aspects rather than code improvement.

Also, I found a satisfactory, yet not perfect solution to loop over the Rmd files of a workflowr project programmatically, to run the same code for different parameterizations.

I try to give you a conceptual example how I do this:

1) I create folders for each version, that already contain a config file with the parameterization details.

2) In the header of each .Rmd file, I define:

params:
  Version_ID: "v_XXX"

In the code, I use params$Version_ID to select the configuration file.
Thus, when I render the Rmd files with wflow_publish(), the standard configuration file from the folder "v_XXX" will be used.

3) This setup allows me to use render() to execute .Rmd files in a for loop, in which I provide a vector of Version_IDs to override the params argument and use alternative config files. The respective code reads:

for (i_Version_IDs in Version_IDs) {
  for (i_files in files) {

    render(
      input = here::here("analysis", i_files),
      output_dir = paste0("/path/to/local/folder",
                          i_Version_IDs,
                          "/website"),
      output_format = html_document(),
      params = list(Version_ID = i_Version_IDs)
    )

    rm(list=setdiff(ls(),
                    c("i_Version_IDs", "Version_IDs",
                      "i_files", "files")))
  }
}

While this approach in general works fine, I'm surprised that it doesn't work when I set the clean=TRUE in render(), which I wanted to do to ensure I do not reuse information from the global environment.
Likewise, I did not manage to execute the inner for loop for one Version_ID as a seperate Job in RStudio, which would be really nice for parallelization.
I guess both issues might result from failure to pass the function arguments forward correctly.

Maybe you know help...



