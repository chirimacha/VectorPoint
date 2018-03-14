jQuery( document ).ready(function() {
  var reconnected = false;
  
  jQuery(window).bind('load', function () {
  	jQuery("div#controls").append('<div class="ver-mas">Ver más</div>');
  	
  	jQuery(".ver-mas").click(function(){
  		if (jQuery(this).text()==="Ver más") {
  			jQuery(this).text("Ver menos");
  			jQuery(this).css("background","#357ebd");
  		}
  		else {
  			jQuery(this).text("Ver más");
  			jQuery(this).css("background","#398439");	
  		}
  		
  	  jQuery("#load, #gps").toggleClass( "mostrar-inline" );
  	  jQuery("#controls .form-group.shiny-input-container, #enterData, #reportUser").toggleClass( "mostrar" );
  	});
  
  });
  
  //Mensaje de validación
  Shiny.addCustomMessageHandler("validation-message",
    function(message) {
      alert(JSON.stringify(message));
    }
  );
  
  //Mensaje de validación
  Shiny.addCustomMessageHandler("confirm-message",
    function(message) {
      var aux = confirm(JSON.stringify(message));
      Shiny.onInputChange("midata", aux);
    }
  );
  
  //Mensaje de accion buscar
  Shiny.addCustomMessageHandler("action-message",
    function(message) {
      str = message;
      if(str=="buscando_true") {
        $('#buscando').css('display','block');
      } else {
        $('#buscando').css('display','none');
      }
    }
  );
  
  //limpia las acciones, como el presionar de un boton
  //envia las varables de estado que necesita el servidor
  function setReconnectVariables() {
    Shiny.shinyapp.$inputValues["inputSubmit:shiny.action"] = 0;
    Shiny.shinyapp.$inputValues["inputCacheInspection:shiny.action"] = 0;
    Shiny.shinyapp.$inputValues["inputClear:shiny.action"] = 0;
    Shiny.shinyapp.$inputValues["btn_filter:shiny.action"] = 0;
    Shiny.shinyapp.$inputValues["gps:shiny.action"] = 0;
    
    if (Shiny.shinyapp.$inputValues["load:shiny.action"] > 0)
      Shiny.shinyapp.$inputValues["load:shiny.action"] = 1;
    
    Shiny.shinyapp.$inputValues["reconnected"] = "true";
    if ( Shiny.shinyapp.$inputValues["userLogin:shiny.action"] == 0 )
      Shiny.shinyapp.$inputValues["reconnected"] = "false";
  }
  
  window.setTimeout(function() {
    Shiny.shinyapp.reconnect = function() {
      
      clearTimeout(Shiny.shinyapp.$scheduleReconnect);
      jQuery("#shiny-notification-reconnect .shiny-notification-content-action a").text("Volver a conectar");
      
      /*if (Shiny.shinyapp.isConnected())
        throw "Attempted to reconnect, but already connected.";
      */
      
      setReconnectVariables();
      
      Shiny.shinyapp.$socket = Shiny.shinyapp.createSocket();
      Shiny.shinyapp.$initialInput = $.extend({}, Shiny.shinyapp.$inputValues);
      Shiny.shinyapp.$updateConditionals();
      
      reconnected = true;
      $('#buscando').css('display','none');
      console.log("reconnecting");
    };
    
    Shiny.shinyapp.$allowReconnect = "force";
  },500);
  
  $("#reconnected").css("display","none");
  
  var node = document.createElement("div");
  node.innerHTML = '<div id="buscando" style="display:none;z-index:9000;position:fixed;top:0;bottom:0;width:100%;background-color:rgba(255,255,255,0.5);"><img class="preloader" src="preloader.gif" style="display: block;margin: 0 auto;"></div>';
  document.getElementsByTagName("body")[0].appendChild(node);
});