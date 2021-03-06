% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat-qq.r
\name{a_stat_qq}
\alias{a_stat_qq}
\alias{a_geom_qq}
\title{Calculation for quantile-quantile plot.}
\usage{
a_stat_qq(mapping = NULL, data = NULL, a_geom = "point",
  a_position = "identity", ..., distribution = stats::qnorm,
  dparams = list(), na.rm = FALSE, show.legend = NA,
  inherit.a_aes = TRUE)

a_geom_qq(mapping = NULL, data = NULL, a_geom = "point",
  a_position = "identity", ..., distribution = stats::qnorm,
  dparams = list(), na.rm = FALSE, show.legend = NA,
  inherit.a_aes = TRUE)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link{a_aes}} or
\code{\link{a_aes_}}. If specified and \code{inherit.a_aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
   options:

   If \code{NULL}, the default, the data is inherited from the plot
   data as specified in the call to \code{\link{a_plot}}.

   A \code{data.frame}, or other object, will override the plot
   data. All objects will be fortified to produce a data frame. See
   \code{\link{a_fortify}} for which variables will be created.

   A \code{function} will be called with a single argument,
   the plot data. The return value must be a \code{data.frame.}, and
   will be used as the layer data.}

\item{a_geom}{The geometric object to use display the data}

\item{a_position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{...}{other arguments passed on to \code{\link{a_layer}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{color = "red"} or \code{size = 3}. They may also be parameters
to the paired a_geom/a_stat.}

\item{distribution}{Distribution function to use, if x not specified}

\item{dparams}{Additional parameters passed on to \code{distribution}
function.}

\item{na.rm}{If \code{FALSE} (the default), removes missing values with
a warning.  If \code{TRUE} silently removes missing values.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}

\item{inherit.a_aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link{borders}}.}
}
\description{
Calculation for quantile-quantile plot.
}
\section{Aesthetics}{

\Sexpr[results=rd,stage=build]{animint2:::rd_aesthetics("a_stat", "qq")}
}

\section{Computed variables}{

\describe{
  \item{sample}{sample quantiles}
  \item{theoretical}{theoretical quantiles}
}
}

\examples{
\donttest{
df <- data.frame(y = rt(200, df = 5))
p <- a_plot(df, a_aes(sample = y))
p + a_stat_qq()
p + a_geom_point(a_stat = "qq")

# Use fitdistr from MASS to estimate distribution params
params <- as.list(MASS::fitdistr(df$y, "t")$estimate)
a_plot(df, a_aes(sample = y)) +
  a_stat_qq(distribution = qt, dparams = params["df"])

# Using to explore the distribution of a variable
a_plot(mtcars) +
  a_stat_qq(a_aes(sample = mpg))
a_plot(mtcars) +
  a_stat_qq(a_aes(sample = mpg, colour = factor(cyl)))
}
}
