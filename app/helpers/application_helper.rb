module ApplicationHelper
  def meses_helper
    {
      'Enero' => 1,
      'Febrero' => 2,
      'Marzo' => 3,
      'Abril' => 4,
      'Mayo' => 5,
      'Junio' => 6,
      'Julio' => 7,
      'Agosto' => 8,
      'Septiembre' => 9,
      'Octubre' => 10,
      'Noviembre' => 11,
      'Diciembre' => 12
    }
  end

  def anio_helper
    Time.now.year..(Time.now + 10.years).year
  end

  def url_to_actividad(actividad, action='')
    raw "/proyecto/actividad#{action}/#{actividad.proyecto.id}/#{actividad.proyecto.codigo_acceso}/#{actividad.id}"
  end

  def url_to_proyecto(actividad, action="")
    raw "/proyecto#{action}/#{actividad.proyecto.id}/#{actividad.proyecto.codigo_acceso}"
  end

  def boolean_icon(bool)
    content_tag(:span, '', class: "glyphicon glyphicon-#{bool ? 'ok' : 'remove'}", style: "color: #{bool ? 'green' : 'red'}; text-align: center;")
  end

  def flash_messages
    # Refactorize this
    if flash[:notice].present?
      type = 'success'
      main = "OK!"
      msg = flash[:notice]
    end

    if flash[:error].present?
      type = 'danger'
      main = "Error!"
      msg = flash[:error]
    end

    if flash[:warning].present?
      type = 'warning'
      main = "Atención!"
      msg = flash[:warning]
    end

    raw("<div class='flash-message alert fade in out alert-#{type}'>
      <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
      <strong>#{main}</strong> #{msg}
    </div>") if flash[:notice].present? || flash[:error].present? || flash[:warning].present?
  end

end
