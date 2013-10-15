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
      $('.actividades_field').last().remove();
    });

    $('#inscribir').on('click', function(e){
      e.preventDefault();
      var estado = "No entre";
      $('form').each(function(){
        $.post(this.action, $(this).serialize() , function(data, textStatus, xhr) {
          console.log('ENVIADO!');
          estado = "SI";
        });
      });
    });
  }

  return {init:init};
})();