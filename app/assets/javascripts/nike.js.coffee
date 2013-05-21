# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  container = $('#container')
  $.ajax
    url: '/d3.json'
    method: 'get'
    dataType: 'json'
    success: (data) ->
      svg = d3.select('div#container svg')
      
      svg.selectAll('rect')
        .data(data)
        .enter()
        .append('rect')
        .attr("height", 0)
        .attr("width", 10)
        .transition()
        .duration(3000)
        .attr("height", (value) -> value)
        .attr("x", (value, i) -> i*15)      
  