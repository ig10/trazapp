module TmpProyectosHelper

  def labeled_estado(estado)
    type = case estado
      when 'aprobado'    then 'success'
      when 'rechazado'  then 'danger'
      when 'pendiente'  then 'warning'
      else
        'default'
      end
    raw("<span class='label label-#{type}'>#{estado.titleize}</span>")
  end

end
