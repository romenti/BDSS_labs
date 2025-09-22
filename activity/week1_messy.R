## week1_messy.R
## NOTE: this script is intentionally BAD. Students should refactor it.

# who cares about working directories lol
setwd("~/Downloads/writingcode/week1")  # <- breaks for everyone else

x = read.csv("data/UNpop_messy.csv")   # stringsAsFactors? meh

# unnecessary packages + inconsistent usage
suppressMessages(library(tidyverse))
library(ggplot2) # loaded twice via tidyverse anyway
library(dplyr)   # also in tidyverse, whatever

# global options because why not
options(scipen = 999)

# random seed (not used)
set.seed(123)

# attach is fine… right?
attach(x)

# print stuff
print("HEAD:")
print(head(x))
print(summary(world.pop))

# duplicate code blocks doing almost the same thing
x$ratio <- x$world.pop / x$world.pop[1]
x$perc  <- round((x$ratio - 1) * 100) # integer rounding? who knows

# mix of base and tidyverse for no reason
x <- x %>% mutate(RATIO = world.pop/world.pop[1], percent = (RATIO-1)*100)

# overwrite columns with different definitions (great idea!)
x$ratio <- x$RATIO
x$Perc <- round(x$percent, 1)

# cryptic variable names
a <- x[,2]
b <- a / a[1]
c <- (b-1)*100
x$p <- c

# Magic numbers & inline calculations
threshold <- 120.5
x$flag <- ifelse(x$p>threshold, TRUE, F)

# write intermediate results somewhere random
write.csv(x, "temp.csv", row.names=F) # what is temp.csv? who knows

# try both plotting systems for fun
plot(x$year, x$p, type="l", col="blue", lwd=3, main="Pop % inc (???)")
abline(h=120, col="red", lty=2)

g <- ggplot(x, aes(year, p)) + geom_line() + geom_point() + 
  geom_hline(yintercept=120.0, linetype="dashed", color="red") +
  labs(title="World pop ?? percent vs 1950", y="perc", x="YEar") +
  theme_minimal()
print(g)

# random pipe with weird spacing & assignment operator confusion
x  =  x |> mutate(   R = world.pop / first(world.pop),   P = round((R-1)*100,1)  )

# inconsistent naming conventions: snakeCase? camelCase? SCREAMING?
names(x)[names(x)=="world.pop"] <- "WorldPop"
x$WORLD_pop <- x$WorldPop

# accidental type conversions for no reason
x$year <- as.character(x$year)
x$year_num <- as.numeric(x$year)

# subset, but keep unused objects + dead code
xx <- subset(x, year_num >= 1960)
yy = xx
zzz <- yy
rm(yy) # but keep zzz, sure

# recompute same metrics again differently (rounding changes!)
xx$rat2 <- xx$WORLD_pop / xx$WORLD_pop[1]
xx$pc2  <- round((xx$rat2-1)*100, 2)

# weird column order
xx <- xx[, c("year", "year_num", "WORLD_pop", "pc2", "p", "R", "P", "flag", "RATIO", "Perc")]

# save to a place no one else has
write.csv(xx, "/Users/nicola/Desktop/output_final.csv", row.names=F)

# print something unreadable
print(xx[ , c(1,3,4,5)])

# detach because we attached earlier (maybe)
detach(x)

# THE END (I guess)