MapView <- 
  div(
    div(
      class = "outer",
      tags$head(#includeHTML("tabs.html"),
        includeCSS("www/css/styles.css"), includeScript("www/js/gomap.js")),
      
      h3(""),
      leafletOutput("map", width = "100%", height = "95%"),
      tags$script(
        '
        $(document).ready(function () {
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
        
        function onError (err) {
        Shiny.onInputChange("geolocation", false);
        }
        
        function onSuccess (position) {
        setTimeout(function () {
        var coords = position.coords;
        console.log(coords.latitude + ", " + coords.longitude);
        Shiny.onInputChange("geolocation", true);
        Shiny.onInputChange("lat", coords.latitude);
        Shiny.onInputChange("long", coords.longitude);
        }, 1100)
        }
        });
        '
      )
    
    ),#--div
    
    absolutePanel(
      id = "logoutPanel",
      class = "panel panel-default",
      fixed = TRUE,
      draggable = TRUE,
      top = 20,
      left = "auto",
      right = 20,
      bottom = "auto",
      width = "auto",
      height = "auto",
      htmlOutput("activeUser"),
      actionLink("logout","Desconectar",width = 60)
    ),
    
    absolutePanel(
      id = "controls",
      class = "panel panel-default",
      tags$head(includeScript("www/js/custom.js")),#tags$script(src="custom.js")), #Agregando archivo JS
      fixed = TRUE,
      draggable = TRUE,
      top = 200,
      left = "auto",
      right = 20,
      bottom = "auto",
      width = 150,
      height = "auto",
      selectizeInput(
        "locality",
        "",
        choices = NULL ,
        multiple = TRUE,
        options = list(placeholder = 'Code Loc'),
        width = '100'
      ),
      actionButton(
        "load",
        icon = icon("refresh", "fa-.5x"),
        "",
        width = 50
      ),
      actionButton(
        "gps",
        icon = icon("crosshairs", "fa-.5x"),
        "",
        width = 50
      ),
      checkboxInput("testData", "Prueba", FALSE),
      uiOutput('inspectButton'),
      htmlOutput("houseProbab"),
      #,HTML("<br>")
      actionButton("enterData", "Entrar Datos"),
      #actionButton("reportUser", "+Información"),
      #actionButton("housesList", "Lista de Casas"),
      textOutput("userMessage")
      #textOutput("houseId")
      #,textOutput("houseProbab")
    )
  )