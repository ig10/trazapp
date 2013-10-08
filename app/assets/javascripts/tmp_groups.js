var TmpGroup = (function(){
  function init(){
    $('#nuevo_alumno').on('click', function(e){
      e.preventDefault();
      var rut = $('.rut').size().toString();
      var nombre = $('.nombre').size().toString();
      var correo = $('.correo').size().toString();
      $.post('partial_alumno', rut: rut, nombre: nombre, correo: correo, function(data, textStatus, xhr) {
        data.appendTo('usuarios_fields');
      });

    });
  }
  return {
    init:init
  };
})();