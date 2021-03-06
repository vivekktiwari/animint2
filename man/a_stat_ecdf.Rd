% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat-ecdf.r
\name{a_stat_ecdf}
\alias{a_stat_ecdf}
\title{Empirical Cumulative Density Function}
\usage{
a_stat_ecdf(mapping = NULL, data = NULL, a_geom = "step",
  a_position = "identity", ..., n = NULL, pad = TRUE, na.rm = FALSE,
  show.legend = NA, inherit.a_aes = TRUE)
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

\item{n}{if NULL, do not interpolate. If not NULL, this is the number
of points to interpolate with.}

\item{pad}{If \code{TRUE}, pad the ecdf with additional points (-Inf, 0)
and (Inf, 1)}

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
Empirical Cumulative Density Function
}
\section{Computed variables}{

\describe{
  \item{x}{x in data}
  \item{y}{cumulative density corresponding x}
}
}

\examples{
\donttest{
df <- data.frame(x = rnorm(1000))
a_plot(df, a_aes(x)) + a_stat_ecdf(a_geom = "step")

df <- data.frame(x = c(rnorm(100, 0, 3), rnorm(100, 0, 10)),
                 g = gl(2, 100))

a_plot(df, a_aes(x, colour = g)) + a_stat_ecdf()
}
}
