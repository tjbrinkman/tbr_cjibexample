# Main script

# Laden van de packages
source('scripts/load_packages.R')

# Dit duurt even
conf <- yaml::read_yaml("config/passwords.yml")

db <- mongo(collection = "almereparkingjson",
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              conf$database$login, 
              conf$database$password, 
              "ds229186.mlab.com:29186",
              "almereparking"))

slow_process <- function(){
  parking <- db$find()
}

fn <- "cache/slow_object.rds"

if(!file.exists(fn)){
  slow_object <- slow_process()
  saveRDS(slow_object, fn)
} else {
  slow_object <- readRDS(fn)
}