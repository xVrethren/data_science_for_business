# ------------------------------------------------------------------------
# Source file: card.R
# Data files:  card.csv
# Output file: card.out
# Content:     Basic R commands; preparation for Card (1995) replication
# -------------------------------------------------------------------------

# LOAD PACKAGES

library(readr)
library(skimr)

# Set working directory  

setwd("C:/Users/cornwl/Dropbox/BUSN 5000/Class_Content/Part_I/current/Scripts")

# Write output of script to a separate file

sink(file="out/card.out",append=FALSE,split=TRUE)   

# Read data file 

card <- read_csv("data/card.csv")

# View data file (console command to open viewer)

View(card)

# Show the first 10 records

head(card, n = 10)

# Examine basic structure of the Card data set

str(card)

# Skim the data set

skim(card)

sink()

