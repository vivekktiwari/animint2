% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fortify-multcomp.r
\name{a_fortify-multcomp}
\alias{a_fortify-multcomp}
\alias{a_fortify.glht}
\alias{a_fortify.confint.glht}
\alias{a_fortify.summary.glht}
\alias{a_fortify.cld}
\title{Fortify methods for objects produced by \pkg{multcomp}}
\usage{
\method{a_fortify}{glht}(model, data, ...)

\method{a_fortify}{confint.glht}(model, data, ...)

\method{a_fortify}{summary.glht}(model, data, ...)

\method{a_fortify}{cld}(model, data, ...)
}
\arguments{
\item{model}{an object of class \code{glht}, \code{confint.glht},
\code{summary.glht} or \code{\link[multcomp]{cld}}}

\item{data, ...}{other arguments to the generic ignored in this method.}
}
\description{
Fortify methods for objects produced by \pkg{multcomp}
}
\examples{
if (require("multcomp")) {
amod <- aov(breaks ~ wool + tension, data = warpbreaks)
wht <- glht(amod, linfct = mcp(tension = "Tukey"))

a_fortify(wht)
a_plot(wht, a_aes(lhs, estimate)) + a_geom_point()

CI <- confint(wht)
a_fortify(CI)
a_plot(CI, a_aes(lhs, estimate, ymin = lwr, ymax = upr)) +
   a_geom_pointrange()

a_fortify(summary(wht))
a_plot(mapping = a_aes(lhs, estimate)) +
   a_geom_linerange(a_aes(ymin = lwr, ymax = upr), data = CI) +
   a_geom_point(a_aes(size = p), data = summary(wht)) +
   a_scale_size(trans = "reverse")

cld <- cld(wht)
a_fortify(cld)
}
}
