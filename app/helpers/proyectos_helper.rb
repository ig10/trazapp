module ProyectosHelper

  def proyecto_estado(estado)
    type = case estado
      when 'activo'   then 'success'
      when 'inactivo' then 'danger'
      when 'expirado' then 'warning'
      when 'evaluado' then 'primary'
      else
        'default'
      end
    raw("<span class='label label-#{type}'>#{estado.titleize}</span>")
  end

end
