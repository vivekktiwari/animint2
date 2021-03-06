% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fortify-map.r
\name{a_fortify.map}
\alias{a_fortify.map}
\title{Fortify method for map objects.}
\usage{
\method{a_fortify}{map}(model, data, ...)
}
\arguments{
\item{model}{map object}

\item{data}{not used by this method}

\item{...}{not used by this method}
}
\description{
This function turns a map into a data frame that can more easily be
plotted with ggplot2.
}
\examples{
if (require("maps")) {
ca <- map("county", "ca", plot = FALSE, fill = TRUE)
head(a_fortify(ca))
a_plot(ca, a_aes(long, lat)) +
  a_geom_polygon(a_aes(group = group))

tx <- map("county", "texas", plot = FALSE, fill = TRUE)
head(a_fortify(tx))
a_plot(tx, a_aes(long, lat)) +
  a_geom_polygon(a_aes(group = group), colour = "white")
}
}
\seealso{
\code{\link{map_data}} and \code{\link{borders}}
}
