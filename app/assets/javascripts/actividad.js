var Actividad = (function(){

  function init(){
    agregar_tarea();
    // cerrar_tarea();
    evaluar_inline();
  }

  function nueva_tarea(){
    cerrar_tarea();
    guardar_tarea();
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
    boton.on('click', function(e){
      e.preventDefault();
      contenedor.hide('slow');
      contenedor.html(false);
    });
  }

  function guardar_tarea(){
    var form = $('#new_tarea');
    var contenedor = $('#form_tarea');
    form.on('submit', function(e){
      e.preventDefault();
      $.post(form.attr('action'), form.serialize(), function(data, status, xhr){
        console.log(xhr);
        if(xhr.status == 200){
          $('.cerrar_tarea').click();
          $('#listado_tareas').html(data);
        }else{
          console.log("ERROR!!");
        }
      });
    });
  }

  function evaluar_inline(){
    var campo = $('.editable');
    campo.on('click', function(e){
      e.preventDefault();
      var elem = $(this);
      var tmpl = "<input class='text_field evaluacion_inline' id='evaluacion' name='evaluacion' size='3' type='text' value='zxc'>";
      var input = elem.find('input[type=text]');
      if(input.size() == 0){
        var actual = $.trim(elem.text());
        elem.html($(tmpl.replace("zxc", actual)));
      }else{
        elem.html("dsds");
      }
    });
  }

  function guardar_evaluacion(){
    var btn = $('.btn-evaluar');
    btn.on('click', function(e){
      e.preventDefault();
      $.post('/evaluar_tarea', btn.data(id).serialize(), function(data, status, xhr){
        if(data == "OK"){

        }
      });
    });
  }

  return {
    init: init,
    nueva_tarea: nueva_tarea
  };
})();