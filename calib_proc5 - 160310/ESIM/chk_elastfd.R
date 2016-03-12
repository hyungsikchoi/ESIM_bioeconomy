require(gdxrrw)
# set the GAMS dir:
igdx("c:/Program Files/GAMS23.7")

# read elastfd parameter:
elfd0 <- rgdx.param("esim_parameters.gdx","elastfd")
elfd1 <- rgdx.param("esim_parameters_40%.gdx","elastfd")

# read all parameters from the file:
fname <- "esim_parameters_40%.gdx"
ginf <- gdxInfo(fname, dump=F, returnList=T)
prms <- ginf$parameters
lprm <- list()
for (p in prms) {
  lprm[[p]] <- rgdx.param(fname, p)
}

subset(elfd0, value>5)
subset(elfd1, value>5)
subset(elfd1, i2!=i3 & value0)
