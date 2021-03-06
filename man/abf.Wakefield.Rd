\name{abf.Wakefield}
\alias{abf.Wakefield}
\title{Calculate approximate Bayes factor (ABF) using method of
  Wakefield (2009).}
\description{
  Calculates an approximation to the Bayes factor for an alternative
  model where the parameter beta is a priori normal, against a smaller
  model where beta is zero, by approximating
  the likelihood function with a normal distribution.
}
\usage{
abf.Wakefield(beta, se, priorsd, log = FALSE)
}
\arguments{
  \item{beta}{Vector of effect size estimates.}
  \item{se}{Vector of associated standard errors.}
  \item{priorsd}{Scalar specifying the standard deviation of the prior
    on true effect sizes.}
  \item{log}{Whether to return results on a natural log scale.}
}
\value{
  A vector of approximate Bayes factors, on a log scale if
  \code{log=TRUE}.  Higher values indicate stronger support for
  association (which is inverted relative to the original definition).
}
\details{
  See \dQuote{Bayes factors for genome-wide association studies:
    comparison with P-values} by John Wakefield, 2009, Genetic
  Epidemiology 33(1):79-86 at \url{http://dx.doi.org/10.1002/gepi.20359}.

  The original definition was for the Bayes factor for the model where
  beta is zero (no association), relative to the model with a normal
  prior for beta (association).  The definition used for this function
  inverts the original definition, so that higher values of the Bayes
  factor (or log Bayes factor) indicate stronger support for
  the model with association.

  For strong associations, calculating Bayes factors may be numerically
  unstable, and it is recommended to work on a log scale and rescale
  appropriately before attempting to calculate Bayes factors or
  posterior probabilities.
}
\examples{
data(agtstats)
agtstats$pval <- with(agtstats, pchisq((beta/se.GC)^2, df = 1, lower.tail = FALSE))
max1 <- function(bf) return(bf/max(bf, na.rm = TRUE))
agtstats$BF.normal <- with(agtstats, max1(abf.Wakefield(beta, se.GC, 0.05)))
agtstats$BF.t <- with(agtstats, max1(abf.t(beta, se.GC, 0.0208)))
with(agtstats, plot(-log10(pval), log(BF.normal)))
with(agtstats, plot(-log10(pval), log(BF.t)))
}
\author{
  Toby Johnson \email{Toby.x.Johnson@gsk.com}
}

