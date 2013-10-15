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
end
