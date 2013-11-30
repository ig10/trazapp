var App = (function(){

  function init(){
    $('.modal').modal({
      keyboard: false,
      backdrop: 'static'
    });
    $('.modal').modal('show');
  }

  function formulario_remoto(){
  /*
   Funcion: Actualiza un elemento del DOM despues de hacer un POST del formulario.
   Requisitos:  → Hash de Opciones del Form tenga "remote:true"
                → Atributo "update=X", donde X es el ID del DIV que se actualizará.
  */
    $('form').each(function(){
      if(this.hasAttribute('update')){
        $(this).bind("ajax:success", function(event, data){
          $("#".concat(this.getAttribute('update'))).html(data);
        });
      }
    });
  }

  return {
    init: init,
    formulario_remoto: formulario_remoto
  };
})();