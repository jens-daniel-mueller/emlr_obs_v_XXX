library(pdftools)
library(tidyverse)

PDF <- pdf_text("data/unadjusted_09AR20041223_316N19941201_ALK.pdf") %>%
  read_lines()

PDF

all_stat_lines <- PDF[62:64] %>%
  str_squish() %>%
  strsplit(split = " ") %>%
  nth(1) %>%
  as_tibble_row(.name_repair = "minimal")

all_stat_lines <- all_stat_lines[1:6]

names(all_stat_lines) <- c("space", "Offset", "O.StDev", "Ratio", "R.Stdev", "Rating")
