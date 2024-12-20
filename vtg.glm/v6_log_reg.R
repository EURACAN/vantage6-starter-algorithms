### Logistic Regression Model ###
# this is the classic data used, "admit" will be the response variable
# dependent on some predictors. Since logistic regression is a continuous
# regression on a binary outcome, "admit" is either 0/1.
# the data can be described in more detail here:
# https://stats.oarc.ucla.edu/r/dae/logit-regression/
rm(list = ls(all.names = 1))
# if vtg.glm is configured correctly you don't need to do devtools::load_all
devtools::load_all("./vtg.glm/src")

library(vtg.glm) # else devtools::load_all("./vtg.glm/src)

data <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
# transform rank into categorical as they do in the reference
data$rank <- factor(data$rank)
# normal logistic regression glm
formula <- admit ~ gre + gpa + rank
family <- binomial()
logit.model <- glm(formula, data = data, family = family)

summary(logit.model)

# federated Logistic regression GLM approach
# Here, in case the 'rank' variable wasn't set as a factor, we can do that
# but in this case we took care of it previously... (here not necessary)

# split data into k=3 parties, random split
# warning is because the number of rows isn't exactly suited for a 3-way split
k <- 3
datasets <- split(data, seq(k))
# check num rows per split data
sapply(datasets, nrow)
# save datasets in your current working directory
invisible(sapply(seq(k), function(i) {
  write.csv(datasets[[i]], file = paste0("logistic_df_", i, ".csv"))
}))

# federated part
types <- c()
types$rank <- list(type = "factor", "levels" = 1:4)
maxit <- 25
family <- "binomial"
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
logistic.dglm <- glm.mock(datasets, formula, family, maxit, types)
str(logistic.dglm)
