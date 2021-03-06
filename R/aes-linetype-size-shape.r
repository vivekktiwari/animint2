#' Differentiation related aesthetics: linetype, size, shape
#'
#' This page demonstrates the usage of a sub-group
#' of aesthetics; linetype, size and shape.
#'
#' @name a_aes_linetype_size_shape
#' @aliases linetype size shape
#' @examples
#'
#' # Line types should be specified with either an integer, a name, or with a string of
#' # an even number (up to eight) of hexadecimal digits which give the lengths in
#' # consecutive positions in the string.
#' # 0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash
#'
#' # Data
#' df <- data.frame(x = 1:10 , y = 1:10)
#' f <- a_plot(df, a_aes(x, y))
#' f + a_geom_line(linetype = 2)
#' f + a_geom_line(linetype = "dotdash")
#'
#' # An example with hex strings, the string "33" specifies three units on followed
#' # by three off and "3313" specifies three units on followed by three off followed
#' # by one on and finally three off.
#' f + a_geom_line(linetype = "3313")
#'
#' # Mapping line type from a variable
#' a_plot(economics_long, a_aes(date, value01)) +
#'   a_geom_line(a_aes(linetype = variable))
#'
#' # Size examples
#' # Should be specified with a numerical value (in millimetres),
#' # or from a variable source
#' p <- a_plot(mtcars, a_aes(wt, mpg))
#' p + a_geom_point(size = 4)
#' p + a_geom_point(a_aes(size = qsec))
#' p + a_geom_point(size = 2.5) +
#'   a_geom_hline(yintercept = 25, size = 3.5)
#'
#' # Shape examples
#' # Shape takes four types of values: an integer in [0, 25],
#' # a single character-- which uses that character as the plotting symbol,
#' # a . to draw the smallest rectangle that is visible (i.e., about one pixel)
#' # an NA to draw nothing
#' p + a_geom_point()
#' p + a_geom_point(shape = 5)
#' p + a_geom_point(shape = "k", size = 3)
#' p + a_geom_point(shape = ".")
#' p + a_geom_point(shape = NA)
#'
#' # Shape can also be mapped from a variable
#' p + a_geom_point(a_aes(shape = factor(cyl)))
#'
#' # A look at all 25 symbols
#' df2 <- data.frame(x = 1:5 , y = 1:25, z = 1:25)
#' s <- a_plot(df2, a_aes(x, y))
#' s + a_geom_point(a_aes(shape = z), size = 4) +
#'   a_scale_shape_identity()
#' # While all symbols have a foreground colour, symbols 19-25 also take a
#' # background colour (fill)
#' s + a_geom_point(a_aes(shape = z), size = 4, colour = "Red") +
#'   a_scale_shape_identity()
#' s + a_geom_point(a_aes(shape = z), size = 4, colour = "Red", fill = "Black") +
#'   a_scale_shape_identity()
NULL
