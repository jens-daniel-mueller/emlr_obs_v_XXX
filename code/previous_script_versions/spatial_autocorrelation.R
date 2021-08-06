
# Spatial autocorrelation

GLODAP_sp <- GLODAP %>%
  filter(depth == 150)

map +
  geom_raster(data = GLODAP_sp,
              aes(lon, lat, fill = temp)) +
  scale_fill_viridis_c()

class(GLODAP_sp)

GLODAP_sp <- GLODAP_sp %>%
  mutate(lon = if_else(lon > 180, lon - 360, lon))

ggplot() +
  geom_raster(data = GLODAP_sp,
              aes(lon, lat, fill = temp)) +
  scale_fill_viridis_c() +
  coord_quickmap()

GLODAP_sp <- as.data.frame(GLODAP_sp)

library(sp)
coordinates(GLODAP_sp) = ~lon+lat
class(GLODAP_sp)

summary(GLODAP_sp)

is.projected(GLODAP_sp)
proj4string(GLODAP_sp) <-
  CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")


GLODAP_sp_grid <- GLODAP_sp

gridded(GLODAP_sp_grid) <- TRUE


spplot(GLODAP_sp,
       zcol = "temp")

spplot(GLODAP_sp_grid,
       zcol = "temp")

library(sf)
library(stars)
GLODAP_sf <- st_as_sf(GLODAP_sp_grid)
GLODAP_stars <- st_as_stars(GLODAP_sp_grid)
class(GLODAP_stars)

plot(GLODAP_stars)

ggplot() +
  geom_stars(data = GLODAP_stars,
             aes(x, y, fill = temp)) +
  scale_fill_viridis_c(na.value = "transparent") +
  coord_quickmap(expand = 0)

library(rnaturalearth)
coastlines <- ne_coastline(scale = "small", returnclass = "sf")

ggplot() +
  geom_sf(data = GLODAP_sf,
          aes(col = temp)) +
  scale_fill_viridis_c(na.value = "transparent") +
  geom_sf(data = st_wrap_dateline(coastlines),
          colour = "black") +
  coord_sf(crs = st_crs('ESRI:54030')) +
  theme_bw()

summary(GLODAP_sp)

library(gstat)
vg_temp <- variogram(temp~1,
                     data = GLODAP_sp_grid,
                     cutoff = 1e4)
fit_temp <- fit.variogram(vg_temp, vgm("Sph"))

plot(vg_temp, fit_temp)

vg_temp <- variogram(temp~1,
                     data = GLODAP_sp_grid,
                     alpha = c(0,90),
                     cutoff = 1e4)
plot(vg_temp)


vg <- gstat(id = params_local$MLR_target,
            formula = as.formula(paste(sym(
              params_local$MLR_target
            ), "~ 1")),
            data = GLODAP_sp_grid)

for (i_var in params_local$MLR_predictors) {
  #i_var <- params_local$MLR_predictors[1]
  vg <- gstat(vg,
              id = i_var,
              formula = as.formula(paste(sym(
                i_var
              ), "~ 1")),
              data = GLODAP_sp_grid)
}



plot(variogram(vg, cutoff = 1e4))

# ### kriging
#
# lzn.kr1 = krige(formula = temp~1,
#                 GLODAP_sp,
#                 GLODAP_sp_grid,
#                 model = fit_temp)
# #> [using universal kriging]
# plot(lzn.kr1[1])

