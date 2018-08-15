#' Dot plot
#'
#' In a dot plot, the width of a dot corresponds to the bin width
#' (or maximum width, depending on the binning algorithm), and dots are
#' stacked, with each dot representing one observation.
#'
#' With dot-density binning, the bin positions are determined by the data and
#' \code{binwidth}, which is the maximum width of each bin. See Wilkinson
#' (1999) for details on the dot-density binning algorithm.
#'
#' With histodot binning, the bins have fixed positions and fixed widths, much
#' like a histogram.
#'
#' When binning along the x axis and stacking along the y axis, the numbers on
#' y axis are not meaningful, due to technical limitations of ggplot2. You can
#' hide the y axis, as in one of the examples, or manually scale it
#' to match the number of dots.
#'
#' @section Aesthetics:
#' \Sexpr[results=rd,stage=build]{animint2:::rd_aesthetics("a_geom", "dotplot")}
#'
#' @inheritParams a_layer
#' @inheritParams a_geom_point
#' @param stackdir which direction to stack the dots. "up" (default),
#'   "down", "center", "centerwhole" (centered, but with dots aligned)
#' @param stackratio how close to stack the dots. Default is 1, where dots just
#'   just touch. Use smaller values for closer, overlapping dots.
#' @param dotsize The diameter of the dots relative to \code{binwidth}, default 1.
#' @param stackgroups should dots be stacked across groups? This has the effect
#'   that \code{a_position = "stack"} should have, but can't (because this geom has
#'   some odd properties).
#' @param binaxis The axis to bin along, "x" (default) or "y"
#' @param method "dotdensity" (default) for dot-density binning, or
#'   "histodot" for fixed bin widths (like a_stat_bin)
#' @param binwidth When \code{method} is "dotdensity", this specifies maximum bin
#'   width. When \code{method} is "histodot", this specifies bin width.
#'   Defaults to 1/30 of the range of the data
#' @param binpositions When \code{method} is "dotdensity", "bygroup" (default)
#'   determines positions of the bins for each group separately. "all" determines
#'   positions of the bins with all the data taken together; this is used for
#'   aligning dot stacks across multiple groups.
#' @param origin When \code{method} is "histodot", origin of first bin
#' @param right When \code{method} is "histodot", should intervals be closed
#'   on the right (a, b], or not [a, b)
#' @param width When \code{binaxis} is "y", the spacing of the dot stacks
#'   for dodging.
#' @param drop If TRUE, remove all bins with zero counts
#' @section Computed variables:
#' \describe{
#'   \item{x}{center of each bin, if binaxis is "x"}
#'   \item{y}{center of each bin, if binaxis is "x"}
#'   \item{binwidth}{max width of each bin if method is "dotdensity";
#'     width of each bin if method is "histodot"}
#'   \item{count}{number of points in bin}
#'   \item{ncount}{count, scaled to maximum of 1}
#'   \item{density}{density of points in bin, scaled to integrate to 1,
#'     if method is "histodot"}
#'   \item{ndensity}{density, scaled to maximum of 1, if method is "histodot"}
#' }
#' @export
#' @references Wilkinson, L. (1999) Dot plots. The American Statistician,
#'    53(3), 276-281.
#' @examples
#' a_plot(mtcars, a_aes(x = mpg)) + a_geom_dotplot()
#' a_plot(mtcars, a_aes(x = mpg)) + a_geom_dotplot(binwidth = 1.5)
#'
#' # Use fixed-width bins
#' a_plot(mtcars, a_aes(x = mpg)) +
#'   a_geom_dotplot(method="histodot", binwidth = 1.5)
#'
#' # Some other stacking methods
#' a_plot(mtcars, a_aes(x = mpg)) +
#'   a_geom_dotplot(binwidth = 1.5, stackdir = "center")
#' a_plot(mtcars, a_aes(x = mpg)) +
#'   a_geom_dotplot(binwidth = 1.5, stackdir = "centerwhole")
#'
#' # y axis isn't really meaningful, so hide it
#' a_plot(mtcars, a_aes(x = mpg)) + a_geom_dotplot(binwidth = 1.5) +
#'   a_scale_y_continuous(NULL, breaks = NULL)
#'
#' # Overlap dots vertically
#' a_plot(mtcars, a_aes(x = mpg)) + a_geom_dotplot(binwidth = 1.5, stackratio = .7)
#'
#' # Expand dot diameter
#' a_plot(mtcars, a_aes(x = mpg)) + a_geom_dotplot(binwidth = 1.5, dotsize = 1.25)
#'
#' \donttest{
#' # Examples with stacking along y axis instead of x
#' a_plot(mtcars, a_aes(x = 1, y = mpg)) +
#'   a_geom_dotplot(binaxis = "y", stackdir = "center")
#'
#' a_plot(mtcars, a_aes(x = factor(cyl), y = mpg)) +
#'   a_geom_dotplot(binaxis = "y", stackdir = "center")
#'
#' a_plot(mtcars, a_aes(x = factor(cyl), y = mpg)) +
#'   a_geom_dotplot(binaxis = "y", stackdir = "centerwhole")
#'
#' a_plot(mtcars, a_aes(x = factor(vs), fill = factor(cyl), y = mpg)) +
#'   a_geom_dotplot(binaxis = "y", stackdir = "center", a_position = "dodge")
#'
#' # binpositions="all" ensures that the bins are aligned between groups
#' a_plot(mtcars, a_aes(x = factor(am), y = mpg)) +
#'   a_geom_dotplot(binaxis = "y", stackdir = "center", binpositions="all")
#'
#' # Stacking multiple groups, with different fill
#' a_plot(mtcars, a_aes(x = mpg, fill = factor(cyl))) +
#'   a_geom_dotplot(stackgroups = TRUE, binwidth = 1, binpositions = "all")
#'
#' a_plot(mtcars, a_aes(x = mpg, fill = factor(cyl))) +
#'   a_geom_dotplot(stackgroups = TRUE, binwidth = 1, method = "histodot")
#'
#' a_plot(mtcars, a_aes(x = 1, y = mpg, fill = factor(cyl))) +
#'   a_geom_dotplot(binaxis = "y", stackgroups = TRUE, binwidth = 1, method = "histodot")
#' }
a_geom_dotplot <- function(mapping = NULL, data = NULL,
                         a_position = "identity",
                         ...,
                         binwidth = NULL,
                         binaxis = "x",
                         method = "dotdensity",
                         binpositions = "bygroup",
                         stackdir = "up",
                         stackratio = 1,
                         dotsize = 1,
                         stackgroups = FALSE,
                         origin = NULL,
                         right = TRUE,
                         width = 0.9,
                         drop = FALSE,
                         na.rm = FALSE,
                         show.legend = NA,
                         inherit.a_aes = TRUE) {
  # If identical(a_position, "stack") or a_position is a_position_stack(), tell them
  # to use stackgroups=TRUE instead. Need to use identical() instead of ==,
  # because == will fail if object is a_position_stack() or a_position_dodge()
  if (!is.null(a_position) &&
      (identical(a_position, "stack") || (inherits(a_position, "a_PositionStack"))))
    message("a_position=\"stack\" doesn't work properly with a_geom_dotplot. Use stackgroups=TRUE instead.")

  if (stackgroups && method == "dotdensity" && binpositions == "bygroup")
    message('a_geom_dotplot called with stackgroups=TRUE and method="dotdensity". You probably want to set binpositions="all"')

  a_layer(
    data = data,
    mapping = mapping,
    a_stat = a_StatBindot,
    a_geom = a_GeomDotplot,
    a_position = a_position,
    show.legend = show.legend,
    inherit.a_aes = inherit.a_aes,
    # Need to make sure that the binaxis goes to both the stat and the geom
    params = list(
      binaxis = binaxis,
      binwidth = binwidth,
      binpositions = binpositions,
      method = method,
      origin = origin,
      right = right,
      width = width,
      drop = drop,
      stackdir = stackdir,
      stackratio = stackratio,
      dotsize = dotsize,
      stackgroups = stackgroups,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname animint2-ggproto
#' @format NULL
#' @usage NULL
#' @export
a_GeomDotplot <- a_ggproto("a_GeomDotplot", a_Geom,
  required_aes = c("x", "y"),
  non_missing_aes = c("size", "shape"),

  default_aes = a_aes(colour = "black", fill = "black", alpha = NA),

  setup_data = function(data, params) {
    data$width <- data$width %||%
      params$width %||% (resolution(data$x, FALSE) * 0.9)

    # Set up the stacking function and range
    if (is.null(params$stackdir) || params$stackdir == "up") {
      stackdots <- function(a)  a - .5
      stackaxismin <- 0
      stackaxismax <- 1
    } else if (params$stackdir == "down") {
      stackdots <- function(a) -a + .5
      stackaxismin <- -1
      stackaxismax <- 0
    } else if (params$stackdir == "center") {
      stackdots <- function(a)  a - 1 - max(a - 1) / 2
      stackaxismin <- -.5
      stackaxismax <- .5
    } else if (params$stackdir == "centerwhole") {
      stackdots <- function(a)  a - 1 - floor(max(a - 1) / 2)
      stackaxismin <- -.5
      stackaxismax <- .5
    }


    # Fill the bins: at a given x (or y), if count=3, make 3 entries at that x
    data <- data[rep(1:nrow(data), data$count), ]

    # Next part will set the position of each dot within each stack
    # If stackgroups=TRUE, split only on x (or y) and panel; if not stacking, also split by group
    plyvars <- params$binaxis %||% "x"
    plyvars <- c(plyvars, "PANEL")
    if (is.null(params$stackgroups) || !params$stackgroups)
      plyvars <- c(plyvars, "group")

    # Within each x, or x+group, set countidx=1,2,3, and set stackpos according to stack function
    data <- plyr::ddply(data, plyvars, function(xx) {
            xx$countidx <- 1:nrow(xx)
            xx$stackpos <- stackdots(xx$countidx)
            xx
          })


    # Set the bounding boxes for the dots
    if (is.null(params$binaxis) || params$binaxis == "x") {
      # ymin, ymax, xmin, and xmax define the bounding rectangle for each stack
      # Can't do bounding box per dot, because y position isn't real.
      # After position code is rewritten, each dot should have its own bounding box.
      data$xmin <- data$x - data$binwidth / 2
      data$xmax <- data$x + data$binwidth / 2
      data$ymin <- stackaxismin
      data$ymax <- stackaxismax
      data$y    <- 0

    } else if (params$binaxis == "y") {
      # ymin, ymax, xmin, and xmax define the bounding rectangle for each stack
      # Can't do bounding box per dot, because x position isn't real.
      # xmin and xmax aren't really the x bounds, because of the odd way the grob
      # works. They're just set to the standard x +- width/2 so that dot clusters
      # can be dodged like other geoms.
      # After position code is rewritten, each dot should have its own bounding box.
      data <- plyr::ddply(data, "group", transform,
            ymin = min(y) - binwidth[1] / 2,
            ymax = max(y) + binwidth[1] / 2)

      data$xmin <- data$x + data$width * stackaxismin
      data$xmax <- data$x + data$width * stackaxismax
      # Unlike with y above, don't change x because it will cause problems with dodging
    }
    data
  },


  draw_group = function(data, panel_scales, a_coord, na.rm = FALSE,
                        binaxis = "x", stackdir = "up", stackratio = 1,
                        dotsize = 1, stackgroups = FALSE) {
    if (!a_coord$is_linear()) {
      warning("a_geom_dotplot does not work properly with non-linear coordinates.")
    }

    tdata <- a_coord$transform(data, panel_scales)

    # Swap axes if using a_coord_flip
    if (inherits(a_coord, "a_CoordFlip"))
      binaxis <- ifelse(binaxis == "x", "y", "x")

    if (binaxis == "x") {
      stackaxis = "y"
      dotdianpc <- dotsize * tdata$binwidth[1] / (max(panel_scales$x.range) - min(panel_scales$x.range))

    } else if (binaxis == "y") {
      stackaxis = "x"
      dotdianpc <- dotsize * tdata$binwidth[1] / (max(panel_scales$y.range) - min(panel_scales$y.range))
    }

    ggname("geom_dotplot",
      dotstackGrob(stackaxis = stackaxis, x = tdata$x, y = tdata$y, dotdia = dotdianpc,
                  stackposition = tdata$stackpos, stackratio = stackratio,
                  default.units = "npc",
                  gp = gpar(col = alpha(tdata$colour, tdata$alpha),
                            fill = alpha(tdata$fill, tdata$alpha)))
    )
  },

  draw_key = a_draw_key_dotplot
)
