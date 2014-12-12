var TmpProyecto = (function(){
  function init(){
    sectionsListener();
    addStudentTrigger();
    removeStudentTrigger();
    fakeLinksEvent();
    submitHandler();
    aproveProject();
  }

  // Add & Remove Students from Select to List and inverse

  function sectionsListener() {
    // Controls change in sections to load students in selector
    $('#tmp_proyecto_seccion_sigla').on('change', function() {
      loadStudents($(this).val());
      cleanListBox();
    });
  }

  function addStudentTrigger() {
    // Controls events from button 'Agregar'
    $('.btn.add').on('click', function(e) {
      e.preventDefault();
      addStudent();
    })
  }

  function removeStudentTrigger() {
    // Listen in ListBox every element to be removed by the X
    var listBox = $('.lista');
    var deleteButton = $('.delete-student');

    listBox.on('click', deleteButton, function(event) {
      removeFromList(event.target);
    });
  }

  function loadStudents(selected) {
    // Loads all the students in the selector from the JSON
    var json = JSON.parse($('#alumnos_json').val());
    var selected = json[selected];
    clearStudentsSelector();
    $.each(selected, function(i, student) {
      appendStudentToSelector(student);
    });
  }

  function clearStudentsSelector() {
    // Resets student selector, removing its elements
    var studentSelector = $('.students-list');
    studentSelector.empty().append($.parseHTML("<option value=''>Seleccione alumno</option>"));
  }

  function addStudent() {
    // Adds a selected student to the List
    var studentSelector = $('.students-list');
    var tmpl = "<span>nombre <span class='delete-student' data-id='id-alumno'>X</span></span>";
    var listBox = $('.lista');
    var student = searchStudent(studentSelector.val());
    removeFromSelector(student);
    listBox.append($.parseHTML(tmpl.replace(/id-alumno/g, student[0]).replace(/nombre/g, student[1])));
  }

  function searchStudent(id) {
    // Retreives an Array of the specific student
    var json = JSON.parse($('#alumnos_json').val());
    var selected = json[$('#tmp_proyecto_seccion_sigla').val()];
    var found;
    $.each(selected, function(i, e) {
      if(e[0] == id){
        found = e;
      }
    });

    return found;
  }

  function removeFromSelector(student) {
    // Removes an option from student selector by its value
    $(".students-list option[value='"+ student[0] +"']").remove();
  }

  function removeFromList(element) {
    // Removes a student from the list when X pressed
    var $element = $(element);
    studentAsOption($element.data('id'));
    $element.parent().remove();
  }

  function studentAsOption(id) {
    // Re-add a removed specific student to the selector
    var student = searchStudent(id);
    var studentSelector = $('.students-list');
    appendStudentToSelector(student);
    sortSelector(studentSelector);
  }

  function sortSelector(selector) {
    // Orders the values from a selector from min to max from its text
    var selectOptions = selector.find('option[value!=""]');
    selectOptions.sort(function(a, b) {
      var aName = $(a).text();
      var bName = $(b).text();
      return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
    });

    clearStudentsSelector();
    selector.append(selectOptions).find('option').first().attr('selected', true);
  }

  function appendStudentToSelector(student) {
    // Function to add an student to the selector list
    var tmpl = "<option value='id'>nombre_completo</option>";
    var studentSelector = $('.students-list');
    studentSelector.append($.parseHTML(tmpl.replace(/id/g, student[0]).replace(/nombre_completo/g, student[1])));
  }

  function cleanListBox() {
    // Resets Listbox to its default state
    $('.lista').empty();
  }

  // MISC

  function fakeLinksEvent() {
    // Cancels click event on links with href eql to #
    $('a').on('click', function(e){
      if($(this).attr('href') == "#"){
        e.preventDefault();
      }
    });
  }

  function submitHandler() {
    var form = $('.new-proyecto');
    var buttonTrigger = $('#inscribir');
    var selectors = $('.students-list');
    var hiddenVariable = $('#lista_alumnos').val();

    buttonTrigger.on('click', function(e) {
      e.preventDefault();
      if ( hiddenVariable != "" || assignStudents() ){
        selectors.attr('disabled',true);
        form.submit();
      } else {
        // Implement Alert.js
        selectors.attr('disabled',false);
        console.log("ERROR");
      }
    });
  }

  function assignStudents() {
    var dataContainers = $('.delete-student');
    var hiddenVariable = $('#lista_alumnos');
    var students = [];
    $.each(dataContainers, function(i, e) {
      students.push($(e).data('id'));
    });
    hiddenVariable.val(students);
    return (hiddenVariable.val() != "");
  }

  function aproveProject() {
    var button = $('a.aprobar');
    var form = $('form.new-proyecto');
    button.on('click', function(e) {
      e.preventDefault();
      saveOldUrl(form.attr('action'));
      form.attr('action', button.attr('href'));
      form.submit();
    });
  }

  function saveOldUrl(str) {
    var button = $('#inscribir');
    var form = $('form.new-proyecto');
    button.attr('data-url', str);
    button.unbind('click');
    button.on('click', function(e) {
      form.attr('action', button.data('url'));
      submitHandler();
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