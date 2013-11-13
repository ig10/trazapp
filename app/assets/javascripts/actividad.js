var Actividad = (function(){

  function init(){
    agregar_tarea();
  }

  function agregar_tarea(){
    var boton = $('#agregar_tarea');
    var contenedor = $('#from_tarea');
    boton.on('click', function(e){
      e.preventDefault();
      $.post("nueva-tarea/".concat(boton.data('id')),function(data){
        contenedor.html(data);
      });
    });
  }

  return {
    init: init
  };
})();