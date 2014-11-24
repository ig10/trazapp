var App = (function(){

  function init(){
    $('.modal').modal({
      keyboard: false,
      backdrop: 'static'
    });
    $('.modal').modal('show');
    formsValidator();
  }

  function formsValidator() {
    $('form').validate();

    soloLetrasYEspacio();

    $.validator.addMethod("valida_rut", function(value, element) {
        return this.optional(element) || rutValido(value);
      });

  }

  function soloLetrasYEspacio() {
    $(".letras_espacio").keypress(function(e) {
      k = (document.all) ? e.keyCode : e.which;
      if (k == 8 || k == 0) return true;
      patron = /^[[A-Za-z\u00C0-\u017F]|\s]*$/;
      n = String.fromCharCode(k);
      return patron.test(n);
    });
  }

  function rutValido(rut) {
    var rut = rut.replace(/\.|-/, "");
    var r = rut.substring(0, rut.length - 1);
    var d = rut.charAt(rut.length - 1);
    rut = r + "-" + d;
    if (parseInt(r) < 2000000) {
      return false;
    } else {
      return (/^[0-9]{1,2}(?:.?[0-9]{3}){2}-[0-9kK]$/i.test(rut) && validarDigitoVerificador(rut) && validateRepeatedNumbers(r));
    }
  }

  function validarDigitoVerificador(val) {
    var todos = val.split("-");
    var rut = todos[0];
    var dv = todos[1];

    var count = 0;
    var count2;
    var factor = 2;
    var suma = 0;
    var sum = 0;
    var digito;
    rut = rut.replace(/\./g, '');
    dv = dv.toUpperCase();
    count2 = rut.length - 1;
    while (count < rut.length) {
      sum = factor * (parseInt(rut.substr(count2, 1)));
      suma = suma + sum;
      sum = 0;
      count = count + 1;
      count2 = count2 - 1;
      factor = factor + 1;
      if (factor > 7) factor = 2;
    }
    digito = 11 - (suma % 11);
    if (digito == 11) digito = 0;
    if (digito == 10) digito = "K";
    return ((digito == dv));
  }

  function validateRepeatedNumbers(rut) {
    return !(/(\d)\1{7,}/.test(rut))
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
    formulario_remoto: formulario_remoto,
    formsValidator: formsValidator
  };
})();