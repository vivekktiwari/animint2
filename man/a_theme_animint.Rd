% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/z_theme_animint.R
\name{a_theme_animint}
\alias{a_theme_animint}
\title{a_theme for passing animint specific params}
\usage{
a_theme_animint(...)
}
\arguments{
\item{...}{a_theme options such as \code{width}. Use \code{update_axes=c("x", "y")} to update the axes of plots. Works for single selection variables.}
}
\value{
ggplot a_theme list with names such as \code{animint.width}.
}
\description{
a_theme without checks. This allows us to write
\code{a_theme_animint(width=500)}, instead of \code{a_theme(animint.width=500)}
which gives an error in ggplot2 because users should be informed
if they mis-type standard a_theme element
names. https://github.com/hadley/ggplot2/issues/938
}
\examples{
mtcars$cyl <- as.factor(mtcars$cyl)
p <- a_plot() +
  a_geom_point(a_aes(x=wt, y=mpg, colour=cyl),
             data=mtcars) +
  ## set width and height values and update both axes
  a_theme_animint(width=600, height=600, update_axes=c("x", "y"))
viz <- list(plot=p, selector.types=list(cyl="single"))
animint2dir(viz)
}
\author{
Toby Dylan Hocking
}
