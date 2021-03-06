% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_map_csv.R
\name{db_map_csv}
\alias{db_map_csv}
\title{Use a sample CSV file to create a Hive table or pass the 'columns' argument to spark_read_csv}
\usage{
db_map_csv(sample_file, db = "sparklyr", sample_size = 5,
  dir_location = NULL, table_name = NULL, ...)
}
\arguments{
\item{sample_file}{The path to a sample CSV file that will be used to determine the column types.}

\item{db}{The type of connection or database. Possible values: 'hive', 'sparklyr'.}

\item{sample_size}{The number of the top rows that will be sampled to determine the class. Defaults to 5.}

\item{dir_location}{'hive' only - Passes the location of the directory where the data files are.}

\item{table_name}{'hive' only - Passes the name of the table. Defaults to 'default'.}
}
\description{
Use a sample CSV file to create a Hive table or pass the 'columns' argument to spark_read_csv
}
\details{
This technique is meant to cut down the time of reading CSV files into the Spark context. It does that by
either passing the column names and types in spark_read_csv or by using SQL to create the table
}
\examples{
\dontrun{
#Libraries needed for this example
library(tidyverse)
library(sparklyr)
library(dbutilities)
library(nycflights13)

#Creating a local spark context
conf <- spark_config()
conf$`sparklyr.shell.driver-memory` <- "16G"
sc <- spark_connect(master = "local",
                    version = "2.1.0",
                    config = conf)

#Using flights from nycflights13 for example
data("flights")
flights

#Creating a csv file out of the flights table
if(!dir.exists("csv"))dir.create("csv")
write_csv(flights, "csv/flights.csv")

#Mapping the CSV file (Hive)
create_sql <- db_map_csv(sample_file = "csv/flights.csv",
                         dir_location = file.path(getwd(), "csv"),
                         db = "hive",
                         table_name = "sql_flights")

#Run resulting SQL command to create the table
DBI::dbGetQuery(sc, create_sql)

#Mapping the CSV file (sparklyr)
flights_columns <- db_map_csv(sample_file = "csv/flights.csv")

#Use spark_read_csv with the infer_schema argument set to FALSE
flights_noinfer <- spark_read_csv(sc,
                                  name = "noinfer_flights",
                                  path = "csv/",
                                  infer_schema = FALSE,
                                  columns = flights_columns)

spark_disconnect(sc)
}
}

