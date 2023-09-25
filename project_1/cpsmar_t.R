# ------------------------------------------------------------------------
# Source file:  cpsmar_t.R
# Data files:   pppub22.csv, hhpub22.csv (from asecpub22csv.zip)
# Output files: LF.csv, cpsmar_t.out, cpsmar_t.csv
# Content:      Downloads and transforms March CPS (ASEC Supplement)
# Notes:        Applied here to March 2022 survey
# Authors:      Kearns and Cornwell
# -------------------------------------------------------------------------

# Load required packages 

library(here)
library(readr)  
library(dplyr)

#-------------------------------------------------------------------------------

# Download data from CPS website and unzip

# temp <- tempfile()
# download.file("https://www2.census.gov/programs-surveys/cps/datasets/2022/march/asecpub22csv.zip", temp) 

# Read person file

# cpsmar <- read_csv(unz(temp,"pppub22.csv")) 
cpsmar <- read_csv(here("project_1", "pppub22.csv")) 

# Read household file and select region and household sequence variables

# hhcps <- read_csv(unz(temp,"hhpub22.csv")) %>% 
hhcps <- read_csv(here("project_1", "hhpub22.csv")) %>%
  select("GEREG", "H_SEQ")

#-------------------------------------------------------------------------------

# LFPR calculation - should equal 62.4%

# PEMLR
# Major labor force recode
# 1 = Employed - at work
# 2 = Employed - absent
# 3 = Unemployed - on layoff
# 4 = Unemployed - looking
# 5 = Not in labor force - retired
# 6 = Not in labor force - disabled
# 7 = Not in labor force - other
# Universe: All Persons

E    <- nrow(cpsmar[cpsmar$PEMLR==1 | cpsmar$PEMLR==2 & cpsmar$A_AGE>15,])
U    <- nrow(cpsmar[cpsmar$PEMLR==3 | cpsmar$PEMLR==4 & cpsmar$A_AGE>15,])
LF   <- E + U
NIFL <- nrow(cpsmar[cpsmar$PEMLR==5 | cpsmar$PEMLR==6 | cpsmar$PEMLR==7 & cpsmar$A_AGE>15,])
Pop  <- NIFL + LF
LFPR <- (LF/Pop)*100

print(paste("March 2022 LFPR =", LFPR))

# Write LFPR calculations to a TXT file 

LF <- data.frame(c("Employed", "Unemployed", "Labor Force", "Not in Labor Force", "Population", "LFPR"),
                 c(E, U, LF, NIFL, Pop, LFPR))
write_csv(LF, here("project_1", "cpsmar_t.csv"), col_names = FALSE)

#-------------------------------------------------------------------------------

