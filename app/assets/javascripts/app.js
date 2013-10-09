var App = (function(){

  function init(){
    $('.modal').modal({
      keyboard: false,
      backdrop: 'static'
    });
    $('.modal').modal('show');
  }

  return {
    init: init
  };
})();