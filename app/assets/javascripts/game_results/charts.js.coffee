class ChartRenderer

  renderChart: (selector, x_label, y_label, data)->

    chart = undefined
    nv.addGraph ->
      chart = nv.models.lineChart().x((d) ->
        d[0]
      ).y((d) ->
        d[1]
      )

      chart.xAxis.axisLabel x_label
      chart.yAxis.axisLabel y_label

      d3.select("#{selector} svg").datum(data).transition().duration(1000).call(chart)

      nv.utils.windowResize chart.update
      nv.utils.windowResize ->
        d3.select("#{selector} svg").call chart

$ ->
  chart_renderer = new ChartRenderer()
  chart_renderer.renderChart("#territories-chart", "Turn", "Territories", territory_data)
  chart_renderer.renderChart("#units-chart", "Turn", "Units", units_data)
  chart_renderer.renderChart("#energy-chart", "Turn", "Energy", energy_data)
  chart_renderer.renderChart("#space-stations-chart", "Turn", "Space Stations", space_station_data)
  chart_renderer.renderChart("#continent-bonus-chart", "Turn", "Continent Bonus", continent_bonus_data)

