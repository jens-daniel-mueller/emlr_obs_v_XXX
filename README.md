# Instructions to run the code in this repository

This code was written as workflowr project to be executed within RStudio.

## Scientific scope

The code in this repository is intended to prepare data sets (either observational or synthetic from an ocean model) for the estimation of anthropogenic carbon in the ocean based on the eMLR(C*) method.

## General instructions

This code was written to be executed within RStudio.

To initiate another sensitivity case, do:

1. Copy the template repository on Github
2. Name it according to version
3. Activate github pages under settings
4. Copy URL in repository description
5. Open as new version controlled project in RStudio
6. Change the `Version_ID` in:  
  - `config_parameterization_local.Rmd`  
  - `_site.yml` title  
7. Change others parameters in `config_parameterization_local.Rmd`
8. Change link to github repo in `_site.yml`
9. Run the code / build the website. All necessary folders will be created automatically
10. Push to github

Workflowr comments for steps 9. and 10. can be found under `/code/workflowr_project_managment.R`


## Parameterization

The analysis runs with a set of apriori local and global parametrizations.

Global parametrizations (such as plotting options) are shared across all sensitivity cases and are loaded in the `setup.Rmd` file (see below).

Local parametrizations (such as eras, density layers, etc) are valid for one sensitivity case and are defined in the `config_parametrization_local.Rmd` file.


## Sharing code across analysis

Background information about several ways for sharing code across analysis in this repository, can be found [here](https://jdblischak.github.io/workflowr/articles/wflow-07-common-code.html) on the workflowr homepage. Here, we apply the use of child documents and functions.

### Using child documents

Code chunks that are used across several .Rmd files are located in `/nfs/kryo/work/jenmueller/emlr_cant/utilities`. Following child documents are available:

- `setup.Rmd`: Defines global options, loads libraries, functions and auxillary files. To run .Rmd files manually, the code in this child document must be executed first (Click "Run all", or Strg+Alt+R). This refers only to documents downstream of read_World_Ocean_Atlas_2018.Rmd, because this is where most auxillary files are created.

### Using functions

Functions are stored in .R files located under `/nfs/kryo/work/jenmueller/emlr_cant/utilities/functions`. Here, it is distinguished between:

`biogeochemical_functions.R` named with prefix b_  

- calculate biogeochemical parameters, such as C*

`mapping_functions.R` named with prefix m_  

- map properties, eg calculate \Delta C~ant~ by applying model coeffcients to predictor climatologies, and perform regional averaging

`plotting_functions.R` named with prefix p_  

- produce maps, zonal mean sections and other plots



## Nomenclature

### Variable names

Variables from source data files are converted and harmonized to satisfy following naming convention throughout the project:

| name | variable | unit |
|---|---|---|
| lon | longitude 20.5 to 379.5 | &deg;E |
| lat | latitude from -89.5 to 89.5 | &deg;N |
| depth | water depth | m |
| bottomdepth | bottomdepth | m |
| sal | salinity | |
| temp | insitu temperature | &deg;C |
| theta | potential temperature | &deg;C |
| gamma | neutral density | kg m^-3^ |
| phosphate | phosphate | &mu;mol kg^-1^ |
| nitrate | nitrate | &mu;mol kg^-1^ |
| silicate | silicate | &mu;mol kg^-1^ |
| oxygen | oxygen | &mu;mol kg^-1^ |
| aou | aparent oxygen utilization | &mu;mol kg^-1^ |
| tco2 | dissolved inorganic carbon | &mu;mol kg^-1^ |
| talk | total alkalinity | &mu;mol kg^-1^ |
| cant | change in anthropogenic CO~2~ concentration | &mu;mol kg^-1^ |
| cstar | C* | &mu;mol kg^-1^ |
| n | number of observations | counts |

### postfix for variables and objects

`_mean`: mean value  
`_sd`: standard deviation  
`_inv`: column inventory  
`_pos`: positive values only (ie negative values set to zero)


## Chunk label naming within .Rmd files

`read_xxx`: open new data set  
`clean_xxx`: subset rows of a data set  
`calculate_xxx`: perform calculations on a data set (add or modify rows)  
`write_xxx`: write summarized data file to disk  

Chunks producing plots are simply named according to the plot content (avoiding a prefix `plot_xxx`), because the generated plot file will be named after the chunk.

## Folder structure

Input data sets (ie output of the preprocessing) are stored under:

- observations: `/nfs/kryo/work/jenmueller/emlr_cant/observations/preprocessing`
- model: `/nfs/kryo/work/jenmueller/emlr_cant/model/preprocessing`

Output data sets of the eMLR analysis are stored under:

- observations: `/nfs/kryo/work/jenmueller/emlr_cant/observations/v_XXX`
- model: `/nfs/kryo/work/jenmueller/emlr_cant/model/v_XXX`

***
&copy; Dr Jens Daniel Müller, ETH Zurich
