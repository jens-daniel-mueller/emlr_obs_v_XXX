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

Version_IDs <- Version_IDs[9]

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
      params = list(Version_ID = i_Version_IDs)
    )

    rm(list=setdiff(ls(),
                    c("i_Version_IDs", "Version_IDs",
                      "i_files", "files")))
  }
}

