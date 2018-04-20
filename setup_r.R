install.packages(c("dplyr", "mlr", "ggplot2", "shiny", "DT", "mlrMBO", "randomForest", "DiceKriging", "rgenoud"),
                 repos = "https://cloud.r-project.org/")
download.file(url = "https://raw.githubusercontent.com/STWUR/STWUR-2018-04-21/master/mieszkania_mlr.csv",
              destfile = "mieszkania_mlr.csv")
