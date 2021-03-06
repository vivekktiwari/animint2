% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom-violin.r, R/stat-ydensity.r
\name{a_geom_violin}
\alias{a_geom_violin}
\alias{a_stat_ydensity}
\title{Violin plot.}
\usage{
a_geom_violin(mapping = NULL, data = NULL, a_stat = "ydensity",
  a_position = "dodge", ..., draw_quantiles = NULL, trim = TRUE,
  a_scale = "area", na.rm = FALSE, show.legend = NA,
  inherit.a_aes = TRUE)

a_stat_ydensity(mapping = NULL, data = NULL, a_geom = "violin",
  a_position = "dodge", ..., bw = "nrd0", adjust = 1,
  kernel = "gaussian", trim = TRUE, a_scale = "area", na.rm = FALSE,
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

\item{a_position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{...}{other arguments passed on to \code{\link{a_layer}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{color = "red"} or \code{size = 3}. They may also be parameters
to the paired a_geom/a_stat.}

\item{draw_quantiles}{If \code{not(NULL)} (default), draw horizontal lines
at the given quantiles of the density estimate.}

\item{trim}{If \code{TRUE} (default), trim the tails of the violins
to the range of the data. If \code{FALSE}, don't trim the tails.}

\item{a_scale}{if "area" (default), all violins have the same area (before trimming
the tails). If "count", areas are scaled proportionally to the number of
observations. If "width", all violins have the same maximum width.}

\item{na.rm}{If \code{FALSE} (the default), removes missing values with
a warning.  If \code{TRUE} silently removes missing values.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}

\item{inherit.a_aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link{borders}}.}

\item{a_geom, a_stat}{Use to override the default connection between
\code{a_geom_violin} and \code{a_stat_ydensity}.}

\item{bw}{the smoothing bandwidth to be used, see
\code{\link{density}} for details}

\item{adjust}{adjustment of the bandwidth, see
\code{\link{density}} for details}

\item{kernel}{kernel used for density estimation, see
\code{\link{density}} for details}
}
\description{
Violin plot.
}
\section{Aesthetics}{

\Sexpr[results=rd,stage=build]{animint2:::rd_aesthetics("a_geom", "violin")}
}

\section{Computed variables}{

\describe{
  \item{density}{density estimate}
  \item{scaled}{density estimate, scaled to maximum of 1}
  \item{count}{density * number of points - probably useless for violin plots}
  \item{violinwidth}{density scaled for the violin plot, according to area, counts
                     or to a constant maximum width}
  \item{n}{number of points}
  \item{width}{width of violin bounding box}
}
}

\examples{
p <- a_plot(mtcars, a_aes(factor(cyl), mpg))
p + a_geom_violin()

\donttest{
p + a_geom_violin() + a_geom_jitter(height = 0)
p + a_geom_violin() + a_coord_flip()

# Scale maximum width proportional to sample size:
p + a_geom_violin(a_scale = "count")

# Scale maximum width to 1 for all violins:
p + a_geom_violin(a_scale = "width")

# Default is to trim violins to the range of the data. To disable:
p + a_geom_violin(trim = FALSE)

# Use a smaller bandwidth for closer density fit (default is 1).
p + a_geom_violin(adjust = .5)

# Add aesthetic mappings
# Note that violins are automatically dodged when any aesthetic is
# a factor
p + a_geom_violin(a_aes(fill = cyl))
p + a_geom_violin(a_aes(fill = factor(cyl)))
p + a_geom_violin(a_aes(fill = factor(vs)))
p + a_geom_violin(a_aes(fill = factor(am)))

# Set aesthetics to fixed value
p + a_geom_violin(fill = "grey80", colour = "#3366FF")

# Show quartiles
p + a_geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))

# Scales vs. coordinate transforms -------
if (require("ggplot2movies")) {
# Scale transformations occur before the density statistics are computed.
# Coordinate transformations occur afterwards.  Observe the effect on the
# number of outliers.
m <- a_plot(movies, a_aes(y = votes, x = rating, group = cut_width(rating, 0.5)))
m + a_geom_violin()
m + a_geom_violin() + a_scale_y_log10()
m + a_geom_violin() + a_coord_trans(y = "log10")
m + a_geom_violin() + a_scale_y_log10() + a_coord_trans(y = "log10")

# Violin plots with continuous x:
# Use the group aesthetic to group observations in violins
a_plot(movies, a_aes(year, budget)) + a_geom_violin()
a_plot(movies, a_aes(year, budget)) +
  a_geom_violin(a_aes(group = cut_width(year, 10)), a_scale = "width")
}
}
}
\references{
Hintze, J. L., Nelson, R. D. (1998) Violin Plots: A Box
Plot-Density Trace Synergism. The American Statistician 52, 181-184.
}
\seealso{
\code{\link{a_geom_violin}} for examples, and \code{\link{a_stat_density}}
  for examples with data along the x axis.
}
