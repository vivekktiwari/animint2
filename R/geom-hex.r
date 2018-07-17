#' Hexagon binning.
#'
#' @section Aesthetics:
#' \Sexpr[results=rd,stage=build]{animint2:::rd_aesthetics("geom", "hex")}
#'
#' @seealso \code{\link{stat_bin2d}} for rectangular binning
#' @param geom,stat Override the default connection between \code{geom_hex} and
#'   \code{stat_binhex.}
#' @export
#' @inheritParams layer
#' @inheritParams geom_point
#' @export
#' @examples
#' d <- a_plot(diamonds, aes(carat, price))
#' d + geom_hex()
#'
#' \donttest{
#' # You can control the size of the bins by specifying the number of
#' # bins in each direction:
#' d + geom_hex(bins = 10)
#' d + geom_hex(bins = 30)
#'
#' # Or by specifying the width of the bins
#' d + geom_hex(binwidth = c(1, 1000))
#' d + geom_hex(binwidth = c(.1, 500))
#' }
geom_hex <- function(mapping = NULL, data = NULL,
                     stat = "binhex", position = "identity",
                     ...,
                     na.rm = FALSE,
                     show.legend = NA,
                     inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = a_GeomHex,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


#' @rdname animint2-ggproto
#' @format NULL
#' @usage NULL
#' @export
a_GeomHex <- a_ggproto("a_GeomHex", a_Geom,
  draw_group = function(data, panel_scales, a_coord) {
    if (!inherits(a_coord, "a_CoordCartesian")) {
      stop("geom_hex() only works with Cartesian coordinates", call. = FALSE)
    }

    a_coord <- a_coord$transform(data, panel_scales)
    ggname("geom_hex", hexGrob(
      a_coord$x, a_coord$y, colour = a_coord$colour,
      fill = alpha(a_coord$fill, a_coord$alpha)
    ))
  },

  required_aes = c("x", "y"),

  default_aes = aes(colour = NA, fill = "grey50", size = 0.5, alpha = NA),

  draw_key = a_draw_key_polygon
)


# Draw hexagon grob
# Modified from code by Nicholas Lewin-Koh and Martin Maechler
#
# @param x positions of hex centres
# @param y positions
# @param vector of hex sizes
# @param border colour
# @param fill colour
# @keyword internal
hexGrob <- function(x, y, size = rep(1, length(x)), colour = "grey50", fill = "grey90") {
  stopifnot(length(y) == length(x))

  dx <- resolution(x, FALSE)
  dy <- resolution(y, FALSE) / sqrt(3) / 2 * 1.15

  hexC <- hexbin::hexcoords(dx, dy, n = 1)

  n <- length(x)

  polygonGrob(
    x = rep.int(hexC$x, n) * rep(size, each = 6) + rep(x, each = 6),
    y = rep.int(hexC$y, n) * rep(size, each = 6) + rep(y, each = 6),
    default.units = "native",
    id.lengths = rep(6, n), gp = gpar(col = colour, fill = fill)
  )
}
