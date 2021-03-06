% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_raster.R
\name{db_raster}
\alias{db_raster}
\title{Computes the frequency of x, y intersections and concentrates them based on the resolution}
\usage{
db_raster(data, resolution = 300, output = "ggplot")
}
\arguments{
\item{data}{Data frame or Spark table}

\item{resolution}{Number of squares to return to plot as raster. Defaults to 300.}

\item{output}{Sets the type of output, defaults to 'data'. Possible values: 'data', 'ggplot'}
}
\description{
Computes the frequency of x, y intersections and concentrates them based on the resolution
}
\details{
The function will use the first two columns in the data set.  Using the dplyr::select statement
prior to calling db_raster will ease adding or removing a plotting step..  The 'data' value
for the 'db' argument will return a data frame instead of a plot.
}
\examples{
\dontrun{
flights \%>\%
  filter(arr_delay < 100) \%>\%
  select(arr_delay, dep_delay) \%>\%
  db_raster()
}

}

