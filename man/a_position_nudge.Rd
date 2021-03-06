% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/position-nudge.R
\name{a_position_nudge}
\alias{a_position_nudge}
\title{Nudge points.}
\usage{
a_position_nudge(x = 0, y = 0)
}
\arguments{
\item{x, y}{Amount of vertical and horizontal distance to move.}
}
\description{
This is useful if you want to nudge labels a little ways from their
points.
}
\examples{
df <- data.frame(
  x = c(1,3,2,5),
  y = c("a","c","d","c")
)

a_plot(df, a_aes(x, y)) +
  a_geom_point() +
  a_geom_text(a_aes(a_label = y))

a_plot(df, a_aes(x, y)) +
  a_geom_point() +
  a_geom_text(a_aes(a_label = y), a_position = a_position_nudge(y = -0.1))
}
\seealso{
Other position adjustments: \code{\link{a_position_dodge}},
  \code{\link{a_position_fill}},
  \code{\link{a_position_identity}},
  \code{\link{a_position_jitterdodge}},
  \code{\link{a_position_jitter}}
}
