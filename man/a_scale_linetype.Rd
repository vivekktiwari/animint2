% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scale-linetype.r
\name{a_scale_linetype}
\alias{a_scale_linetype}
\alias{a_scale_linetype_continuous}
\alias{a_scale_linetype_discrete}
\title{Scale for line patterns.}
\usage{
a_scale_linetype(..., na.value = "blank")

a_scale_linetype_continuous(...)

a_scale_linetype_discrete(..., na.value = "blank")
}
\arguments{
\item{...}{common discrete scale parameters: \code{name}, \code{breaks},
\code{a_labels}, \code{na.value}, \code{limits} and \code{a_guide}.  See
\code{\link{discrete_a_scale}} for more details}

\item{na.value}{The linetype to use for \code{NA} values.}
}
\description{
Default line types based on a set supplied by Richard Pearson,
University of Manchester.  Line types can not be mapped to continuous
values.
}
\examples{
base <- a_plot(economics_long, a_aes(date, value01))
base + a_geom_line(a_aes(group = variable))
base + a_geom_line(a_aes(linetype = variable))

# See a_scale_manual for more flexibility
}
