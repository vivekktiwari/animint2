library(animint2)
library(gridExtra)

#' Demonstrates axis specification, serves as a tutorial to introduce animint (eventually?)
# Randomly generate some data
scatterdata <- data.frame(x=rnorm(100, 50, 15))
scatterdata$y <- with(scatterdata, runif(100, x-5, x+5))
scatterdata$xnew <- round(scatterdata$x/20)*20
scatterdata$xnew <- as.factor(scatterdata$xnew)
scatterdata$class <- factor(round(scatterdata$x/10)%%2, labels=c("high", "low"))
scatterdata$class4 <- factor(rowSums(sapply(quantile(scatterdata$x)+c(0,0,0,0,.1), function(i) scatterdata$x<i)), levels=1:4, labels=c("high", "medhigh", "medlow", "low"), ordered=TRUE)

#' qplot-style specification works for simple examples, 
#' but may not continue to work for more complicated 
#' combinations... 
#' TODO: Test further.
p <- qplot(data=scatterdata, x=x, y=y, a_geom="point", colour=floor(x))
# gg2animint(list(p=p))

#' Should use empty a_plot() statement because of structure of a_plot/qplot object
#' Must provide a named list of ggplots.
s1 <- a_plot() + a_geom_point(data=scatterdata, a_aes(x=x, y=y)) +
  xlab("very long x axis label") + 
  ylab("very long y axis label") +
  ggtitle("Titles are awesome")
s1
# gg2animint(list(s1=s1))

#' Colors, Demonstrates axis -- works with factor data
#' Specify colors using R color names
s2 <- a_plot() + a_geom_point(data=scatterdata, a_aes(x=xnew, y=y), colour="blue") +
  ggtitle("Colors are cool")
s2
# gg2animint(list(s1=s1, s2=s2))

#' Specify colors manually using hex values
s3 <- a_plot() + 
  a_geom_point(data=scatterdata, a_aes(x=xnew, y=y, colour=class, fill=class)) + 
  a_scale_colour_manual(values=c("#FF0000", "#0000FF")) + 
  a_scale_fill_manual(values=c("#FF0000", "#0000FF")) +
  ggtitle("Manual color/fill scales")
s3
# gg2animint(list(s1=s1, s2=s2, s3=s3))

#' Categorical color scales 
s4 <- a_plot() + a_geom_point(data=scatterdata, a_aes(x=xnew, y=y, colour=xnew, fill=xnew)) +
  ggtitle("Categorical color/fill scales")
s4
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4))

#' Use a_geom_jitter and color by another variable
s5 <- a_plot() + a_geom_jitter(data=scatterdata, a_aes(x=xnew, y=y, colour=class4, fill=class4)) +
  ggtitle("a_geom_jitter")
s5
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5))

#' Color by x*y axis (no binning)
s6 <- a_plot() + a_geom_point(data=scatterdata, a_aes(x=x, y=y, color=x*y, fill=x*y)) +
  ggtitle("Continuous color scales")
s6
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6))

#' Overplotting data for testing alpha
library(plyr)
scatterdata2 <- data.frame(x=rnorm(1000, 0, .5), y=rnorm(1000, 0, .5))
scatterdata2$quad <- c(3, 4, 2, 1)[with(scatterdata2, (3+sign(x)+2*sign(y))/2+1)]
scatterdata2$quad <- factor(scatterdata2$quad, labels=c("Q1", "Q2", "Q3", "Q4"), ordered=TRUE)
scatterdata2 <- ddply(scatterdata2, .(quad), transform, str=sqrt(x^2+y^2)/4)
scatterdata2.summary <- ddply(scatterdata2, .(quad), summarise, xmin=min(x), xmax=max(x), ymin=min(y), ymax=max(y), xmean=mean(x), ymean=mean(y))
qplot(data=scatterdata2, x=x, y=y, a_geom="point", colour=quad)

#' Interactive plots...
s7 <- a_plot() + 
  a_geom_rect(data=scatterdata2.summary,
            a_aes(xmax=xmax, xmin=xmin, ymax=ymax, ymin=ymin, colour=quad, fill=quad),
            clickSelects = "quad", alpha=.3) +
  a_geom_point(data=scatterdata2.summary, a_aes(x=xmean, y=ymean, colour=quad, fill=quad),
             showSelected = "quad", size=5) +
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y), alpha=.15) + 
  a_scale_colour_discrete(a_guide="legend") + a_scale_fill_discrete(a_guide="legend") +
  a_scale_alpha_discrete(a_guide="none") +
  ggtitle("Selects & Means")
s7
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7))

#' Single alpha value
s8 <- a_plot() + 
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad),alpha=.2)+
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad), 
             clickSelects="quad", showSelected="quad", alpha=.6) +
  a_guides(colour = a_guide_legend(override.a_aes = list(alpha = 1)), 
         fill = a_guide_legend(override.a_aes = list(alpha = 1))) +
  ggtitle("Constant alpha")
s8
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7, s8=s8))

#' Continuous alpha
s9 <- a_plot() +
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad),alpha=.2)+
  a_geom_point(data=scatterdata2,
             a_aes(x=x, y=y, colour=quad, fill=quad, alpha=str),
             clickSelects="quad", showSelected="quad") +
  a_guides(colour = a_guide_legend(override.a_aes = list(alpha = 1)), 
         fill = a_guide_legend(override.a_aes = list(alpha = 1))) +
  a_scale_alpha(range=c(.6, 1), a_guide="none") +
  ggtitle("Continuous alpha")
s9
# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7, s8=s8, s9=s9))

#' Categorical alpha and a_scale_alpha_discrete()
#' Note, to get unselected points to show up, need to have two copies of a_geom_point: One for anything that isn't selected, one for only the selected points.
s10 <- a_plot() + 
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad, alpha=quad))+
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad, alpha=quad),
             clickSelects="quad", showSelected="quad") +
  a_guides(colour = a_guide_legend(override.a_aes = list(alpha = 1)), 
         fill = a_guide_legend(override.a_aes = list(alpha = 1))) +
  a_scale_alpha_discrete(a_guide="none")+
  ggtitle("Discrete alpha")
s10

# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7, s8=s8, s9=s9, s10=s10))


#' Point Size Scaling
#' a_scale defaults to radius, but area is more easily interpreted by the brain (Tufte).
s11 <- a_plot() + 
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad, size=str), alpha=.5) +
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad, size=str),
             clickSelects="quad", showSelected="quad", alpha=.3) +
  ggtitle("Scale Size")
s11

# gg2animint(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7, s8=s8, s9=s9, s10=s10, s11=s11))

s12 <- a_plot() + 
  a_geom_point(data=scatterdata2, a_aes(x=x, y=y, colour=quad, fill=quad, size=str), alpha=.5) + 
  a_scale_size_area() +
  ggtitle("Scale Area")
s12

animint2dir(list(s1=s1, s2=s2, s3=s3, s4=s4, s5=s5, s6=s6, s7=s7, s8=s8, s9=s9, s10=s10, s11=s11, s12=s12))

