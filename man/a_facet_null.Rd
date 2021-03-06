% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/facet-null.r
\name{a_facet_null}
\alias{a_facet_null}
\title{Facet specification: a single panel.}
\usage{
a_facet_null(shrink = TRUE)
}
\arguments{
\item{shrink}{If \code{TRUE}, will shrink scales to fit output of
statistics, not raw data. If \code{FALSE}, will be range of raw data
before statistical summary.}
}
\description{
Facet specification: a single panel.
}
\examples{
# facet_null is the default facetting specification if you
# don't override it with facet_grid or facet_wrap
a_plot(mtcars, a_aes(mpg, wt)) + a_geom_point()
}
