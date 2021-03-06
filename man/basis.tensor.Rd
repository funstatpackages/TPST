% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/basis.tensor.R
\name{basis.tensor}
\alias{basis.tensor}
\title{Tensor-product Splines over a Triangular Prism Partition}
\usage{
basis.tensor(
  ss,
  tt,
  V,
  Tri,
  d = 2,
  r = 1,
  time.knots,
  time.bound,
  rho = 3,
  line.up = FALSE
)
}
\arguments{
\item{ss}{If \code{line.up=TRUE}, \code{ss} is the spatial cooridinates of dimension \code{nS} by two. If \code{line.up=TRUE}, \code{ss} is the spatial cooridinates of dimension \code{n} by two. Each row is the spatial coordinates of a point.
\cr}

\item{tt}{If \code{line.up=TRUE}, the temporal cooridinates of length \code{nT}. If \code{line.up=FALSE}, the temporal cooridinates of length \code{nT}. Each value is the temporal coordinates of a point.
\cr}

\item{V}{The \code{N} by two matrix of vertices of a triangulation, where \code{N} is the number of vertices. Each row is the coordinates for a vertex.
\cr}

\item{Tri}{The triangulation matrix of dimention \code{nTr} by three, where \code{nTr} is the number of triangles in the triangulation. Each row is the indices of vertices in \code{V}.
\cr}

\item{d}{The degree of piecewise polynomials -- default is 2, and usually \code{d} is greater than one. -1 represents piecewise constant.
\cr}

\item{r}{The smoothness parameter -- default is 1, and 0 \eqn{\le} \code{r} \eqn{<} \code{d}.
\cr}

\item{time.knots}{The vector of interior time.knots for univariate spline.
\cr}

\item{time.bound}{The vector of two. The boundary of univariate spline.
\cr}

\item{rho}{The order of univaraite spline.
\cr}

\item{line.up}{The indicator of whether the observed points are temporally lined up or not -- default is \code{FALSE}.
\cr}
}
\value{
A list of vectors and matrices, including:
\item{Psi}{The spline basis function of dimension \code{n} by \code{(l)}\code{(nTr)}\code{{(d+1)(d+2)/2}}, where \code{l} is the number of univariate basis, \code{n} is the number of observationed points, \code{nTr} is the number of triangles in the given triangulation, and \code{d} is the degree of the spline. If some points do not fall in the triangulation, the generation of the spline basis will not take those points into consideration.}
\item{Psi.Q2}{The spline basis function after QR decomposition}
\item{H}{The smoothness matrix for bivariate spline.}
\item{Q2}{The Q2 matrix after QR decomposition of the smoothness matrix \code{H}.}
\item{H.all}{The smoothness matrix for tensor-product spline.}
\item{Q2.all}{The Q2 matrix after QR decomposition of the smoothness matrix \code{H.all} for tensor-product spline.}
\item{dimB}{The number of bivariate spline basis functions.}
\item{dimU}{The number of univariate spline basis functions.}
\item{P1, P2}{The penalty matrices from energy functions.}
\item{K1, K2}{The penalty matrices from energy functions QR decomposition.}
}
\description{
This function generates the basis for tensor-product splines over a triangular prism partition.
}
\examples{
# load need libraries.
# Packages BPST and Triangulation could be downloaded from github.
rm(list = ls())
library(devtools)
install_github("funstatpackages/BPST")
install_github("funstatpackages/Triangulation")
library(Triangulation)
library(TPST)
data(Tr1)
data(V1)

ngrid.x=40
ngrid.y=20
ngrid.t=10

xx=seq(-0.89,3.39,length.out=ngrid.x)
yy=seq(-0.89,0.89,length.out=ngrid.y)
ss=expand.grid(xx,yy)
tt=(0:(ngrid.t-1))/(ngrid.t-1)

Data=data.frame(x=rep(ss[,1],ngrid.t),y=rep(ss[,2],ngrid.t),
              t=rep(tt,each=dim(ss)[1]))
knots=c(0.2,0.4,0.6,0.8)
Boundary.knots=c(0,1)

d <- 2
r <- 1
rho <- 3
Basis1 <- basis.tensor(ss = ss, tt = tt, V = V1, Tri = Tr1,
                     d = d, r = r, time.knots = knots, rho = rho,
                     time.bound = Boundary.knots, line.up = TRUE)

Basis2 <- basis.tensor(ss = Data[,1:2], tt = Data[,3],
                      V = V1, Tri = Tr1, d = d, r = r,
                    time.knots = knots, rho = rho,
                    time.bound = Boundary.knots, line.up = FALSE)

which(Basis1$Psi.Q2 != Basis2$Psi.Q2)
}
