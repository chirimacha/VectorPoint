#' VectorPoint 
#' Copyright (c) 2015-2017  VectorPoint team
#' See LICENSE.TXT for details
#' 
#' User Interface

#Paquetes utilizados en la aplicacion
library(shiny)
library(datasets)
library(RColorBrewer)
library(leaflet)
library(htmltools)
library(lattice)
library(dplyr)
library(rgdal)
library(rdrop2)
library(data.table)
library(RMySQL)
library(shinyjs)
library(deldir)
library(sp)
library(data.table)
library(DBI)
library(shinyBS)
library(shinythemes)

#Codigo externo utilizado
  #Server.R
    #Funciones utilizadas
    source("controller/loadSaveMethods.R")
    #Colores
    source("controller/palettes.R")
    #Triangulacion
    source("controller/delaunayTriangulationFunctions.R")
  #Ui.R
    source("view/LoginForm.R")
    source("view/DataEntryForm.R")
    source("view/MapView.R")
    source("view/ReportUserView.R")
    source("view/ReportAdminView.R")

shinyUI(fluidPage(
  mainPanel(
    " ",
    conditionalPanel(
      "output.validUser != 'Success'",
      
      #Formulario para ingreso de usuario
      LoginForm
      
    ),
    conditionalPanel(
      "output.validUser == 'Success' & output.adminUser != 'Success'",
      
      #Formulario para el ingreso de datos
      DataEntryForm,
      
      #Reporte que puede ver el usuario
      ReportUserView,
      
      conditionalPanel(
        "output.validUser == 'Success' & output.adminUser != 'Success'",
        
        #La vista del mapa y botones que interactuan con él
        MapView
        
      )
    ),#---conditionalPanel
    
    #Administrador
    #conditionalPanel(
      #"output.adminUser == 'Success'",
      #ReporAdminView
    #),#---conditionalPanel
    
    textInput("reconnected",NULL)
    
  )#---mainPanel
))

