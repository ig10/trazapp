var TmpProyecto = (function(){
  function init(){
    $('#secciones').on('change', function() {
      loadStudents($(this).val());
    });

    addStudentTrigger();

    $('a').on('click', function(e){
      if($(this).attr('href') == "#"){
        e.preventDefault();
      }
    });
  }

  function loadStudents(selected) {
    var json = JSON.parse($('#alumnos_json').val());
    var studentSelector = $('.students-list');
    var tmpl = "<option value='id'>nombre_completo</option>";
    var selected = json[selected];
    removeStudents();
    $.each(selected, function(i, e) {
      var optionBase = tmpl;
      studentSelector.append($.parseHTML(optionBase.replace(/id/g, e[0]).replace(/nombre_completo/g, e[1])));
    });
  }

  function removeStudents() {
    var studentSelector = $('.students-list');
    studentSelector.empty().append($.parseHTML("<option>Seleccione alumno</option>"));
  }

  function addStudentTrigger() {
    $('.btn.add').on('click', function(e) {
      e.preventDefault();
      addStudent();
    })
  }

  function addStudent() {
    var studentSelector = $('.students-list');
    var tmpl = "<span data-id='id-alumno'>nombre</span>";
    var listBox = $('.lista');
    var student = searchStudent(studentSelector.val());

    listBox.append($.parseHTML(tmpl.replace(/id-alumno/g, student[0]).replace(/nombre/g, student[1])));
  }

  function searchStudent(id) {
    var json = JSON.parse($('#alumnos_json').val());
    var selected = json[$('#secciones').val()];
    var found;
    $.each(selected, function(i, e) {
      if(e[0] == id){
        found = e;
      }
    });

    return found;
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
      var boton = $(element);
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