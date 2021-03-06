% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coord-munch.r
\name{spiral_arc_length}
\alias{spiral_arc_length}
\title{Spiral arc length}
\usage{
spiral_arc_length(a, theta1, theta2)
}
\arguments{
\item{a}{A vector of spiral "slopes". Each spiral is defined as r = a * theta.}

\item{theta1}{A vector of starting theta values.}

\item{theta2}{A vector of ending theta values.}
}
\description{
Each segment consists of a spiral line of slope 'a' between angles
'theta1' and 'theta2'. Because each segment has its own _normalized_
slope, the ending theta2 value may not be the same as the starting
theta1 value of the next point.
}
\examples{
animint2:::spiral_arc_length(a = c(0.2, 0.5), c(0.5 * pi, pi), c(pi, 1.25 * pi))
}
\keyword{internal}
