#' Create a multi-armed bandit object.
#' 
#' @description Fit a multi-armed bandit object based on a bayesTest which can serve recommendations and adapt
#' to new data.
#' 
#' @param bT a bayesTest object
#' @param param which model parameter (posterior) to evaluate 
#' @param higher_is_better  is a higher value of `param` equivalent to a better choice?
#' @return A bayesBandit object.
#' 
#' @details \code{banditize} is an 'object-oriented' implementation of multi-armed bandits in \code{bayesAB}. It is useful in 
#' conjunction with a Shiny app or Plumber deployment. The object itself is mutable and can adapt/learn from new data without having to
#' re-assign the variable. 
#' 
#' Comes with 5 methods:
#' 
#' \itemize{
#'  \item \code{serveRecipe()}: serves a recipe to show your user based on samples from both posteriors.
#'  \item \code{setResults(results)}: set results for one or more recipes for one or more instances of feedback. Used to update bandit.
#'  \item \code{getBayesTest()}: returns most updated \code{bayesTest} object.
#'  \item \code{getOriginalTest()}: returns original \code{bayesTest} object without any updates.
#'  \item \code{getUpdates()}: returns a summarized version of all updates this bandit has processed.}
#' 
#' @examples
#' A_binom <- rbinom(100, 1, .5)
#' B_binom <- rbinom(100, 1, .6)
#' 
#' AB1 <- bayesTest(A_binom, B_binom, priors = c('alpha' = 1, 'beta' = 1), distribution = 'bernoulli')
#' 
#' binomialBandit <- banditize(AB1)
#' binomialBandit$serveRecipe
#' binomialBandit$setResults(c('A' = 1, 'A' = 0, 'B' = 0, 'B' = 0))
#' 
#' @export
banditize <- function(bT, param, higher_is_better = TRUE) {
  
  ## Only 2 recipes for now
  choices <- c('A', 'B')
  
  ## switch for higher_is_better
  compareFun <- ifelse(higher_is_better, which.max, which.min)
  
  test <- bT
  
  ## Initialize counters and updates tracking
  updates <- 0
  A_ctr <- 0
  B_ctr <- 0
  
  serveRecipe <- function() {
    ## exploit iid samples from posterior
    idx <- sample(test$inputs$n_samples, 1)
    A_sample <- test$posteriors[[param]]$A_probs[idx]
    B_sample <- test$posteriors[[param]]$B_probs[idx]
    
    return(choices[compareFun(c(A_sample, B_sample))])
  }
  
  setResults <- function(results) {
    if(!(all(names(results) %in% choices))) stop("`results` vector must only contain names 'A' and 'B'")
    
    As <- unname(results[names(results) == 'A'])
    Bs <- unname(results[names(results) == 'B'])
    
    A_ctr <- A_ctr + length(As)
    B_ctr <- B_ctr + length(Bs)
    
    test <<- bayesTest(c(test$inputs$A_data, As),
                       c(test$inputs$B_data, Bs),
                       test$inputs$priors,
                       test$inputs$n_samples,
                       test$distribution)
    
    return(0)
  }
  
  getBayesTest <- function() {
    return(test)
  }
  
  getOriginalTest <- function() {
    return(bT)
  }
  
  getUpdates <- function() {
    cat(updates, "updates to this bandit.\n")
    
    summarizeUpdates <- function(vec, name) cat(name, "has had", length(vec), "additions with a mean of", mean(vec), ".\n")
    
    summarizeUpdates(tail(test$inputs$A_data, A_ctr), "A")
    summarizeUpdates(tail(test$inputs$B_data, B_ctr), "B")
  }
  
  out <- list("serveRecipe" = serveRecipe,
              "setResults" = setResults,
              "getBayesTest" = getBayesTest,
              "getOriginalTest" = getOriginalTest,
              "getUpdates" = getUpdates)
  
  class(out) <- 'bayesBandit'
  
  return(out)
  
}