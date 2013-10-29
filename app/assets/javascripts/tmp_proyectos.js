var TmpProyecto = (function(){
  function init(){
    $('#nuevo_alumno').on('click', function(e){
      e.preventDefault();
      var alumnos = ($('.user_fields').size()+1).toString();
      var tmpl = '<div class="user_fields extended"><input class="text_field usuario" id="alumno_1_rut" name="alumno_1[rut]" placeholder="Rut" type="text" value=""><input class="text_field usuario" id="alumno_1_nombre_completo" name="alumno_1[nombre_completo]" placeholder="Nombre y Apellidos" type="text" value=""><input class="text_field usuario" id="alumno_1_correo_electronico" name="alumno_1[correo_electronico]" placeholder="Correo Electrónico" type="text" value=""></div>'.replace(/1/g, alumnos);
      $(tmpl).appendTo('.alumnos');
    });

    $('#eliminar_alumno').on('click', function(e){
      e.preventDefault();
      $('.user_fields').last().remove();
    });

    $('#nueva_actividad').on('click', function(e){
      e.preventDefault();
      var actividad = $('.actividades_field');
      var cantidad = (actividad.size()+1).toString();
      var tmpl = actividad.first().clone().html().replace(/actividad_1/g,"actividad_".concat(cantidad));
      $("<tr class='actividades_field'>"+tmpl+"</tr>").appendTo(actividad.parent());
    });

    $('#eliminar_actividad').on('click', function(e){
      e.preventDefault();
      var actividades = $('.actividades_field');
      if(actividades.size() > 1){
        actividades.last().remove();
      }
    });

    $('#inscribir').on('click', function(e){
      e.preventDefault();
      var form = $('form');
      $.post(form.attr('action'), form.serialize(), function(data, status, xhr){
        console.log(data, status, xhr);
        if(data=="OK"){
          $('.alert').show();
        }
      });
    });

    $('a').on('click', function(e){
      if($(this).attr('href') == "#"){
        e.preventDefault();
      }
    });
  }

  function profesor(){
    $('a').on('click', function(e){
      if($(this).attr('href') == "#"){
        e.preventDefault();
      }
    });

    $('.checkbox').on('change', function(){
      $('.cant_proyectos').text($('.checkbox:checked').size());
    });

    $('.aprobar').on('click', function(e){
      aprobar_proyecto($(this));
    });

    $('.aprobar_multiples').on('click', function(e){
      $('.checkbox:checked').each(function(element){
        var botonAprobar = $(element).parent().siblings().find('.aprobar');
        aprobar_proyecto(botonAprobar);
      });
    });

    function aprobar_proyecto(element){
      var boton = $(elem);
      var id = boton.data('id').toString();
      var codigo = boton.parent().prev().text();
      if(!boton.hasClass('disabled')){
        $.post("solicitud/aprobar/"+id+"/"+codigo, function(data, status, xhr){
          if(data == "OK"){
            boton.addClass('disabled');
            $(boton.parent().siblings()[2]).text('aprobado');
          }else{
            boton.addClass('btn-warning').removeClass('btn-success');
            console.log(data, status, xhr);
          }
        });
      }
    }

  }

  return {init:init, profesor:profesor};
})();