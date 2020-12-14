# Instructions to run the code in this repository

## Scientific scope

The code in this repository is intended to estimate anthropogenic carbon in the ocean based on the eMLR(C*) method. Two separate template versions exist to be run on observational or synthetic data from a ocean BGC model.

# General instructions

This code was written to be executed within RStudio.

1. Copy the template repository on Github.
2. Name it according to version.
3. Activate github pages under settings.
4. Copy URL in repository description.
5. Open as new version controlled project in RStudio.
6. Change the `Version_ID` in:
  a. config_parameterization_local.Rmd
  b. _site.yml title
7. Change others parameters in `config_parameterization_local.Rmd.`
8. Change link to github repo in _site.yml.
9. Run the code / build the website. All necessary folders will be created automatically.
10. Push to github.

Workflowr comments for steps 9. and 10. can be found under `/code/workflowr_project_managment.R`


## Sharing code across analysis

Background information about sharing code across analysis in this repository, can be found [here](https://jdblischak.github.io/workflowr/articles/wflow-07-common-code.html){target="_blank"} on the workflowr homepage.

## Parameterization

The analysis runs with a set of apriori local and global parameterizations.

Global parameterizations (such as plotting options) are shared across all sensitivity cases and are defined in the setup.Rmd file (see below).

Local parameterizations (such as eras, density layers, etc) are valid for one sensitivity case and are defined in the config_parameterization_local.Rmd file.


## Using child documents

Code chunks that are used across several .Rmd files are located in "/nfs/kryo/work/updata/emlr_cant/utilities". Following child documents are available:

- setup.Rmd: Defines global options, loads libraries, functions and auxillary files. To run .Rmd files manually, the code in this child document must be executed first (Click "Run all", or Strg+Alt+R). This refers only to documents downstream of read_World_Ocean_Atlas_2018.Rmd, because this is where most auxillary files are created.


## Using functions

Functions are stored in .R files located under "/nfs/kryo/work/updata/emlr_cant/utilities/functions". Here, it is distinguished between:

biogeochemical_functions.R  

- calculate biogeochemical parameters, such as C*

mapping_functions.R  

- map properties, eg calculate \Delta C~ant~ by appliying model coeffcients to predictor climatologies, and regional averaging

plotting_functions.R  

- produce maps, zonal mean sections and other plots


## Unevaluated chunks

By setting the plot_all_figures argument in config_parameterization_local to "y", following code chunks will be executed:

in eMLR_data_preparation.Rmd  

- plot_all_individual_cruises_clean

in eMLR_assumption_testing.Rmd  

- predictor_correlation_per_basin_era_slab  

in eMLR_model_fitting.Rmd  

- fit_best_models (only plot commands uncommented within loop)

in mapping_cant_calculation.Rmd  

- cant_section_by_model_eras_lon  

Respective code chunks create a high number of diagnostic figures as separate output which results in higher runtime of the code.


# Variables

Variables from source data files are converted and harmonized to satisfy following naming convention throughout the project:

- coordinates on 1x1 degree grid
  - lon: longitude (20.5 to 379.5 °E)
  - lat: latitude (-89.5 to 89.5 °N)
- depth: water depth (m)
- bottomdepth: bottomdepth (m)

- sal: salinity (Check scales!)
- tem: insitu temperature in deg C (Check scales!)
- theta: potential temperature in deg C (Check scales!)
- gamma: neutral density

- phosphate
- nitrate
- silicate
- oxygen
- phosphate_star
- aou

- tco2
- talk

- cant: anthropogenic CO~2~ (mol kg^-1^)
- cstar: C* (mol kg^-1^)

# Variable and data set post fix

- _mean: mean value
- _sd: standard deviation
- _inv: column inventory
- _pos: positive values only (ie negative values set to zero)
- _3d: XYZ fields of mapped parameters
- _zonal: Zonal mean sections

# Data sets / objects

- cant_
- cstar_

# Chunk label naming within .Rmd files

- read_xxx: open new data set
- clean_xxx: subset rows of a data set
- calculate_xxx: perform calculations on a data set (add or modify rows)
- write_xxx: write summarized data file to disk
- chunks producing plots are named according to the plot content, because the generated plot file will be named after the chunk

# Functions

Functions are stored in separate .R files. This include function for:

- mapping with a prefix "m_"
- plotting with a prefix "p_"
- biogeochemical calculations with a prefix "b_"

# Folder structure

Preprocessed observational data and climatologies are available at "/nfs/kryo/work/updata/emlr_cant/observations/preprocessing/". This path is defined initially defined in each analysis script as path_preprocessing.


# Open tasks

- check temperature and salinity scales 



A [workflowr][] project.

[workflowr]: https://github.com/jdblischak/workflowr
