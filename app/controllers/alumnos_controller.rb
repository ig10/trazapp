class AlumnosController < ApplicationController
  def index

      @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "Proyectos de Título")
        f.xAxis(:categories => ["Proyectos"])
        f.series(:name => "Aprobados", :yAxis => 0, :data => [510], :color => 'blue')
        f.series(:name => "Reprobados", :yAxis => 0, :data => [310], :color => 'red')

        f.yAxis [
          {:title => {:text => "Cantidad", :margin => 20} }
        ]
        f.chart({:defaultSeriesType =>"column"} )
        f.legend(:align => 'right', :layout => 'vertical', :verticalAlign => 'middle')
      end
    end
end