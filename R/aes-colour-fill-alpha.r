#' Colour related aesthetics: colour, fill and alpha
#'
#' This page demonstrates the usage of a sub-group
#' of aesthetics; colour, fill and alpha.
#'
#' @name a_aes_colour_fill_alpha
#' @aliases colour color fill
#' @examples
#' \donttest{
#'
#' # Bar chart example
#' c <- a_plot(mtcars, a_aes(factor(cyl)))
#' # Default plotting
#' c + a_geom_bar()
#' # To change the interior colouring use fill aesthetic
#' c + a_geom_bar(fill = "red")
#' # Compare with the colour aesthetic which changes just the bar outline
#' c + a_geom_bar(colour = "red")
#' # Combining both, you can see the changes more clearly
#' c + a_geom_bar(fill = "white", colour = "red")
#'
#' # The aesthetic fill also takes different colouring scales
#' # setting fill equal to a factor variable uses a discrete colour scale
#' k <- a_plot(mtcars, a_aes(factor(cyl), fill = factor(vs)))
#' k + a_geom_bar()
#'
#' # Fill aesthetic can also be used with a continuous variable
#' m <- a_plot(faithfuld, a_aes(waiting, eruptions))
#' m + a_geom_raster()
#' m + a_geom_raster(a_aes(fill = density))
#'
#' # Some geoms don't use both a_aesthetics (i.e. a_geom_point or a_geom_line)
#' b <- a_plot(economics, a_aes(x = date, y = unemploy))
#' b + a_geom_line()
#' b + a_geom_line(colour = "green")
#' b + a_geom_point()
#' b + a_geom_point(colour = "red")
#'
#' # For large datasets with overplotting the alpha
#' # a_aesthetic will make the points more transparent
#' df <- data.frame(x = rnorm(5000), y = rnorm(5000))
#' h  <- a_plot(df, a_aes(x,y))
#' h + a_geom_point()
#' h + a_geom_point(alpha = 0.5)
#' h + a_geom_point(alpha = 1/10)
#'
#' # Alpha can also be used to add shading
#' j <- b + a_geom_line()
#' j
#' yrng <- range(economics$unemploy)
#' j <- j + a_geom_rect(a_aes(NULL, NULL, xmin = start, xmax = end, fill = party),
#' ymin = yrng[1], ymax = yrng[2], data = presidential)
#' j
#' j + a_scale_fill_manual(values = alpha(c("blue", "red"), .3))
#' }
NULL
