library(furrr)
library(purrr)

map(c("hello", "world"), ~.x)
future_map(c("hello", "world"), ~.x)



library(tictoc)
plan(sequential)

tic()
nothingness <- future_map(c(2, 2, 2), ~Sys.sleep(.x))
toc()

plan(multisession, workers = 3)

tic()
nothingness <- future_map(c(2, 2, 2), ~Sys.sleep(.x))
toc()


future_map_dbl(1:4, function(x){
  Sys.sleep(1)
  x^2
}, .progress = TRUE)





# test parallel processing

# expand with model definitions


# test multidplyr

# library(parallel)
# library(multidplyr)
#
# n_cores <- detectCores()
# system.time(
# cluster <- new_cluster(n_cores - 2)
# )
#
# cluster
#
# system.time(
#   GLODAP_nested_lm_part <-
#     GLODAP_nested_lm %>%
#     #group_by(gamma_slab, era, basin, data_source, model, predictors, n) %>%
#     partition(cluster)
# )
#
#
# GLODAP_nested_lm
# GLODAP_nested_lm_part
#
# system.time(cluster %>%
#               cluster_library(c("tidyverse",
#                                 "broom",
#                                 "olsrr",
#                                 "purrr")))
#
# cluster_call(cluster, search())
#
# system.time(
# GLODAP_nested_lm_fit <- GLODAP_nested_lm_part %>%
#   mutate(
#     fit = map2(.x = data, .y = model,
#                ~ lm(as.formula(.y), data = .x)),
#     tidied = map(fit, tidy),
#     glanced = map(fit, glance),
#     augmented = map(fit, augment),
#     vif = map(fit, ols_vif_tol)
#   )
# )
#
# system.time(
#   # extract glanced model output (model diagnostics, such as AIC)
#   GLODAP_glanced <- GLODAP_nested_lm_fit %>%
#     select(-c(data, fit, tidied, augmented, vif))
#     # unnest(glanced) %>%
#     # rename(n_predictors = n)
# )
#
#
# system.time(
# GLODAP_nested_lm_fit <- GLODAP_nested_lm_fit %>%
#   collect()
# )


### test furrr

# library(furrr)
#
# plan(multisession, workers = 10)
#
# tic()
# GLODAP_nested_lm_fit_furrr <- GLODAP_nested_lm %>%
#   mutate(
#     fit = future_map2(.x = data, .y = model,
#                ~ lm(as.formula(.y), data = .x)),
#     tidied = future_map(fit, tidy),
#     glanced = future_map(fit, glance),
#     augmented = future_map(fit, augment),
#     vif = future_map(fit, ols_vif_tol)
#   )
# toc()
#
# plan(sequential)

# print(object.size(GLODAP_nested), units = "MB")
# print(object.size(GLODAP_nested_lm), units = "MB")
# print(object.size(GLODAP_nested_lm_fit), units = "MB")
