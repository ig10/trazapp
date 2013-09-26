var App = (function(){

  function init(){
    $("body").on("click",".ui-dialog button", function() {
     $("[data-role='dialog']").dialog("close");
    });
    $(document).on("mobileinit", function(){
      $.mobile.defaultPageTransition = "slide";
    });
  }

  return {
    init: init
  };
})();