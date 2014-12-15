class ProfesoresController < ApplicationController
  def index
    @chart_c = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Proyectos de Título")
      f.xAxis(:categories => ["Proyectos"])
      f.series(:name => "Aprobados", :yAxis => 0, :data => [510])
      f.series(:name => "Reprobados", :yAxis => 0, :data => [310])

      f.yAxis [
        {:title => {:text => "Cantidad", :margin => 20} }
      ]
      f.chart({:defaultSeriesType=>"column", :margin=> [60]} )
      f.legend(:align => 'right', :layout => 'vertical', :verticalAlign => 'middle')
    end

    @chart_p = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 20, 20, 30]} )
      series = {
        :type=> 'pie',
        :data=> [
          ['Activos', 200],
          ['Pendientes', 25],
        ]
      }
      f.series(series)
      f.legend( :layout=> 'vertical')
      f.plot_options(:pie=>{
        :allowPointSelect=>true,
        :cursor=>"pointer" ,
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :distance=>5,
          :style=>{
            :font=>"11px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end

    @chart_l = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(:name=>'Proyecto 1',:data=> [7, 5, 5])
      f.series(:name=>'Proyecto 2',:data=>[6, 6, 5] )
      f.title({:text=>"Seguimiento de Evaluaciones"})
      f.options[:chart][:defaultSeriesType] = "line"
      f.xAxis(:categories => ["Evaluación 1", "Evaluación 2", "Evaluación 3"])
      f.yAxis(:minRange=>0, :max=>7, :title=>{:text=>"Nota"})
      #f.legend(:align => 'right', :layout => 'vertical', :verticalAlign => 'middle')
    end
  end
end