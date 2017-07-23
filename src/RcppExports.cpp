// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// PoissonClosed_
double PoissonClosed_(double alpha_1, double beta_1, double alpha_2, double beta_2);
RcppExport SEXP _bayesAB_PoissonClosed_(SEXP alpha_1SEXP, SEXP beta_1SEXP, SEXP alpha_2SEXP, SEXP beta_2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type alpha_1(alpha_1SEXP);
    Rcpp::traits::input_parameter< double >::type beta_1(beta_1SEXP);
    Rcpp::traits::input_parameter< double >::type alpha_2(alpha_2SEXP);
    Rcpp::traits::input_parameter< double >::type beta_2(beta_2SEXP);
    rcpp_result_gen = Rcpp::wrap(PoissonClosed_(alpha_1, beta_1, alpha_2, beta_2));
    return rcpp_result_gen;
END_RCPP
}
// BernoulliClosed_
double BernoulliClosed_(double alpha_1, double beta_1, double alpha_2, double beta_2);
RcppExport SEXP _bayesAB_BernoulliClosed_(SEXP alpha_1SEXP, SEXP beta_1SEXP, SEXP alpha_2SEXP, SEXP beta_2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type alpha_1(alpha_1SEXP);
    Rcpp::traits::input_parameter< double >::type beta_1(beta_1SEXP);
    Rcpp::traits::input_parameter< double >::type alpha_2(alpha_2SEXP);
    Rcpp::traits::input_parameter< double >::type beta_2(beta_2SEXP);
    rcpp_result_gen = Rcpp::wrap(BernoulliClosed_(alpha_1, beta_1, alpha_2, beta_2));
    return rcpp_result_gen;
END_RCPP
}
