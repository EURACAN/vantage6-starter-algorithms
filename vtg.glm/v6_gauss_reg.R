### Gaussian Regression Model ###
# the point here is to identify predictors that together give some linear
# combination in order to observe some response variable
# here, we require some continuous response variable so the data needed.
# we will use the most basic dataset found in R to study this function,
# but Matteo's example is similar... just I cannot find anything about where
# he found this data so I rather not use it!
# dataset is of cherry trees volume, you can read more about it by running
# `?dataset::trees`. It comes with base R.
# the response is the Volume and the predictory is Girth, ignoring height.
rm(list = ls(all.names = 1))
# if vtg.glm is configured correctly you don't need to do devtools::load_all
devtools::load_all("./vtg.glm/src")
library(vtg.glm) # else devtools::load_all("./vtg.glm/src)

data <- datasets::trees
# we will add log(Volume) as the response rather than just the Volume... will
# make a more interesting curve when you plot results
formula <- log(Volume) ~ Girth
family <- gaussian()
gauss.model <- glm(formula, data = data, family = family)

summary(gauss.model)

# federated Gassian regression GLM approach

# split data into k=2 parties, random split (i use 2 because the data is small)
k <- 3
datasets <- split(data, seq(k))
# check num rows per split data
sapply(datasets, nrow)
# save datasets in your current working directory, don't need it to return
# any output so wrap in invisible...
invisible(sapply(seq(k), function(i) {
  write.csv(datasets[[i]], file = paste0("gauss_df_", i, ".csv"))
}))

# federated part
maxit <- 25
family <- "gaussian"
glm.mock <- function(datasets, formula, family, maxit, types) {
  client <- vtg::MockClient$new(datasets = datasets, pkgname = "vtg.glm")
  result <- vtg.glm::dglm(
    client = client,
    formula = formula,
    family = family,
    maxit = maxit,
    types = types
  )
  return(result)
}
# results
gauss.dglm <- glm.mock(datasets, formula, family, maxit, NULL)
str(gauss.dglm)
