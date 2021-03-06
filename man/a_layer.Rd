% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layer.r
\name{a_layer}
\alias{a_layer}
\title{Create a new layer}
\usage{
a_layer(a_geom = NULL, a_stat = NULL, data = NULL, mapping = NULL,
  a_position = NULL, params = list(), inherit.a_aes = TRUE,
  subset = NULL, show.legend = NA)
}
\arguments{
\item{a_geom}{The geometric object to use display the data}

\item{a_stat}{The statistical transformation to use on the data for this
layer, as a string.}

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

\item{mapping}{Set of aesthetic mappings created by \code{\link{a_aes}} or
\code{\link{a_aes_}}. If specified and \code{inherit.a_aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{a_position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{params}{Additional parameters to the \code{a_geom} and \code{a_stat}.}

\item{inherit.a_aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link{borders}}.}

\item{subset}{DEPRECATED. An older way of subsetting the dataset used in a
layer.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}
}
\description{
A layer is a combination of data, stat and a_geom with a potential position
adjustment. Usually layers are created using \code{a_geom_*} or \code{a_stat_*}
calls but it can also be created directly using this function.
}
\examples{
# geom calls are just a short cut for layer
a_plot(mpg, a_aes(displ, hwy)) + a_geom_point()
# shortcut for
a_plot(mpg, a_aes(displ, hwy)) +
  a_layer(a_geom = "point", a_stat = "identity", a_position = "identity",
    params = list(na.rm = FALSE)
  )

# use a function as data to plot a subset of global data
a_plot(mpg, a_aes(displ, hwy)) +
  a_layer(a_geom = "point", a_stat = "identity", a_position = "identity",
    data = head, params = list(na.rm = FALSE)
  )

}
