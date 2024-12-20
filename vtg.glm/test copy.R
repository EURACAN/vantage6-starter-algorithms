# Clear the environment completely
rm(list = ls(all.names = TRUE))
# devtools::load_all("./vtg.preprocessing/R")
devtools::load_all("./vtg.glm/src")

library(vtg.glm)

d1 <- read.csv("C:/Users/bbe2101.54580/data/vantage6/glm/a.csv")
d2 <- read.csv("C:/Users/bbe2101.54580/data/vantage6/glm/b.csv")
d3 <- read.csv("C:/Users/bbe2101.54580/data/vantage6/glm/c.csv")
dataset <- list(d1, d2, d3)

formula <- "num_awards ~ prog + math"

types <- list()
types$prog <- list("type" = "factor", "levels" = c("General", "Academic", "Vocational"))

glm.mock <- function(dataset, formula, family, maxit) {
  client <- vtg::MockClient$new(datasets = dataset, pkgname = "vtg.glm")
  result <- vtg.glm::dglm(
    client = client,
    formula = formula,
    family = family,
    maxit = maxit,
    types = types
  )
  return(result)
}

# res <- glm.mock(dataset, formula, "poisson", 0)
res <- glm.mock(dataset, formula, "poisson", 200)
print(res)
