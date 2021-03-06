% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theme-elements.r
\name{rel}
\alias{rel}
\title{Relative sizing for theme elements}
\usage{
rel(x)
}
\arguments{
\item{x}{A number representing the relative size}
}
\description{
Relative sizing for theme elements
}
\examples{
df <- data.frame(x = 1:3, y = 1:3)
a_plot(df, a_aes(x, y)) +
  a_geom_point() +
  a_theme(axis.title.x = a_element_text(size = rel(2.5)))
}
