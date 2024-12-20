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


glm.mock <- function(dataset, formula, family, maxit) {
  client <- vtg::MockClient$new(datasets = dataset, pkgname = "vtg.glm")
  result <- vtg.glm::dglm(
    client = client,
    formula = formula,
    family = family,
    maxit = maxit,
  )
  return(result)
}

# res <- glm.mock(dataset, formula, "poisson", 0)
res <- glm.mock(dataset, formula, "poisson", 200)

# library(survival)
# vars <- all.vars(as.formula(formula))
# d2 <- vtg.preprocessing::extend_data(d1)
# d3 <- vtg.preprocessing::subset_data(d2, subset_rules)
# res_local <- survival::survfit(
#   formula = as.formula(formula),
#   data = na.omit(d3[, vars]),
#   conf.type = conf.type,
# )


### OLD GLM test script
# # Clear the environment completely
# rm(list = ls(all.names = TRUE))

# # This seems to be equivalent to "import x as y"
# library(namespace)
# tryCatch({
#     invisible(registerNamespace('vtg', loadNamespace('vtg')))
# }, error = function(e) {
#     vtg::writeln("Package 'vantage.infrastructure' already loaded.")
# })

# library(vtg.basic)

# setup.client <- function(local=TRUE) {
#     username <- "****"
#     password <- "****"
#     collaboration_id_tcr <- 1
#     collaboration_id_ucsc <- 2
#     collaboration_id_test <- 3
#     host <- 'https://api-test.distributedlearning.ai'
#     api_path <- ''

#     if (local) {
#         vtg::writeln("Using LOCAL collaboration\n")
#         collaboration_id <- collaboration_id_test
#     } else {
#         vtg::writeln("Using UCSC collaboration")
#         collaboration_id <- collaboration_id_ucsc
#     }

#     client <- vtg::Client$new(host, api_path=api_path)
#     client$authenticate(username, password)
#     client$setCollaborationId(collaboration_id)

#     return(client)
# }

# setup.mock.client <- function(splits=2) {
#     data(SEER, package='vtg.basic')
#     df <- SEER
#     datasets <- list()

#     for (k in 1:splits) {
#         datasets[[k]] <- df[seq(k, nrow(df), by=splits), ]
#     }

#     client <- vtg::MockClient(datasets)
# }

# client <- setup.mock.client()
# result <- hello(client, "Melle")

# writeln()
# writeln(rep('-', 80), sep='')
# writeln('results:')
# writeln(rep('-', 80), sep='')
# print(result)
