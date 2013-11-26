var Actividad = (function(){

  function init(){
    agregar_tarea();
    // cerrar_tarea();
  }

  function agregar_tarea(){
    var boton = $('#agregar_tarea');
    var contenedor = $('#form_tarea');
    boton.on('click', function(e){
      e.preventDefault();
      $.post("nueva-tarea/".concat(boton.data('id')),function(data){
        contenedor.html(data);
        contenedor.show('slow');
        setTimeout("window.scroll(0, $('#form_tarea').position().top);", 650)
      });
    });
  }

  function cerrar_tarea(){
    var boton = $('.cerrar_tarea');
    var contenedor = $('#form_tarea');
    contenedor.on('click', boton, function(e){
      e.preventDefault();
      contenedor.html(false);
    });
  }

  function guardar_tarea(){
    var form = $('#new_tarea');
    var contenedor = $('#form_tarea');
    form.on('submit', function(e){
      e.preventDefault();
      $.post(form.attr('action'), form.serialize(), function(data){
        console.log(data);
        if(data == "OK"){
          contenedor.hide('slow');
          contenedor.html(false);
        }else{
          console.log("ERROR!!");
        }
      });
    });
  }

  return {
    init: init,
    guardar_tarea: guardar_tarea
  };
})();