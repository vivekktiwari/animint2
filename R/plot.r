#' Create a new a_plot plot.
#'
#' \code{a_plot()} initializes a a_plot object. It can be used to
#' declare the input data frame for a graphic and to specify the
#' set of plot aesthetics intended to be common throughout all
#' subsequent layers unless specifically overridden.
#'
#' \code{a_plot()} is typically used to construct a plot
#' incrementally, using the + operator to add layers to the
#' existing a_plot object. This is advantageous in that the
#' code is explicit about which layers are added and the order
#' in which they are added. For complex graphics with multiple
#' layers, initialization with \code{a_plot} is recommended.
#'
#' There are three common ways to invoke \code{a_plot}:
#' \itemize{
#'    \item \code{a_plot(df, a_aes(x, y, <other a_aesthetics>))}
#'    \item \code{a_plot(df)}
#'    \item \code{a_plot()}
#'   }
#' The first method is recommended if all layers use the same
#' data and the same set of aesthetics, although this method
#' can also be used to add a layer using data from another
#' data frame. See the first example below. The second
#' method specifies the default data frame to use for the plot,
#' but no aesthetics are defined up front. This is useful when
#' one data frame is used predominantly as layers are added,
#' but the aesthetics may vary from one layer to another. The
#' third method initializes a skeleton \code{a_plot} object which
#' is fleshed out as layers are added. This method is useful when
#' multiple data frames are used to produce different layers, as
#' is often the case in complex graphics.
#'
#' @param data Default dataset to use for plot. If not already a data.frame,
#'   will be converted to one by \code{\link{a_fortify}}. If not specified,
#'   must be suppled in each layer added to the plot.
#' @param mapping Default list of aesthetic mappings to use for plot.
#'   If not specified, must be suppled in each layer added to the plot.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @param environment If an variable defined in the aesthetic mapping is not
#'   found in the data, a_plot will look for it in this environment. It defaults
#'   to using the environment in which \code{a_plot()} is called.
#' @export
#' @examples
#' df <- data.frame(gp = factor(rep(letters[1:3], each = 10)),
#'                  y = rnorm(30))
#' # Compute sample mean and standard deviation in each group
#' ds <- plyr::ddply(df, "gp", plyr::summarise, mean = mean(y), sd = sd(y))
#'
#' # Declare the data frame and common aesthetics.
#' # The summary data frame ds is used to plot
#' # larger red points in a second a_geom_point() layer.
#' # If the data = argument is not specified, it uses the
#' # declared data frame from a_plot(); ditto for the aesthetics.
#' a_plot(df, a_aes(x = gp, y = y)) +
#'    a_geom_point() +
#'    a_geom_point(data = ds, a_aes(y = mean),
#'               colour = 'red', size = 3)
#' # Same plot as above, declaring only the data frame in a_plot().
#' # Note how the x and y aesthetics must now be declared in
#' # each a_geom_point() layer.
#' a_plot(df) +
#'    a_geom_point(a_aes(x = gp, y = y)) +
#'    a_geom_point(data = ds, a_aes(x = gp, y = mean),
#'                  colour = 'red', size = 3)
#' # Set up a skeleton a_plot object and add layers:
#' a_plot() +
#'   a_geom_point(data = df, a_aes(x = gp, y = y)) +
#'   a_geom_point(data = ds, a_aes(x = gp, y = mean),
#'                         colour = 'red', size = 3) +
#'   a_geom_errorbar(data = ds, a_aes(x = gp, y = mean,
#'                     ymin = mean - sd, ymax = mean + sd),
#'                     colour = 'red', width = 0.4)
a_plot <- function(data = NULL, mapping = a_aes(), ...,
                   environment = parent.frame()) {
  UseMethod("a_plot")
}

#' @export
#' @rdname a_plot
#' @usage NULL
a_plot.default <- function(data = NULL, mapping = a_aes(), ...,
                           environment = parent.frame()) {
  a_plot.data.frame(a_fortify(data, ...), mapping, environment = environment)
}

#' @export
#' @rdname a_plot
#' @usage NULL
a_plot.data.frame <- function(data, mapping = a_aes(), ...,
                              environment = parent.frame()) {
  if (!missing(mapping) && !inherits(mapping, "uneval")) {
    stop("Mapping should be created with `a_aes() or `a_aes_()`.", call. = FALSE)
  }

  p <- structure(list(
    data = data,
    layers = list(),
    scales = a_scales_list(),
    mapping = mapping,
    a_theme = list(),
    coordinates = a_coord_cartesian(),
    a_facet = a_facet_null(),
    plot_env = environment
  ), class = c("aaa", "a_plot"))

  p$a_labels <- make_labels(mapping)

  set_last_plot(p)
  p
}

a_plot_clone <- function(plot) {
  p <- plot
  p$scales <- plot$scales$clone()

  p
}

#' Reports whether x is a a_plot object
#' @param x An object to test
#' @keywords internal
#' @export
is.a_plot <- function(x) inherits(x, "a_plot")

#' Draw plot on current graphics device.
#'
#' @param x plot to display
#' @param newpage draw new (empty) page first?
#' @param vp viewport to draw plot in
#' @param ... other arguments not used by this method
#' @keywords hplot
#' @return Invisibly returns the result of \code{\link{a_plot_build}}, which
#'   is a list with components that contain the plot itself, the data,
#'   information about the scales, panels etc.
#' @export
#' @method print a_plot
print.a_plot <- function(x, newpage = is.null(vp), vp = NULL, ...) {
  set_last_plot(x)
  if (newpage) grid.newpage()

  # Record dependency on 'animint2' on the display list
  # (AFTER grid.newpage())
  grDevices::recordGraphics(
    requireNamespace("animint2", quietly = TRUE),
    list(),
    getNamespace("animint2")
  )

  data <- a_plot_build(x)

  gtable <- a_plot_gtable(data)
  if (is.null(vp)) {
    grid.draw(gtable)
  } else {
    if (is.character(vp)) seekViewport(vp) else pushViewport(vp)
    grid.draw(gtable)
    upViewport()
  }

  invisible(data)
}
#' @rdname print.a_plot
#' @method plot a_plot
#' @export
plot.a_plot <- print.a_plot
