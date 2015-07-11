// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  var yellow = $(".yellow").length
  var green = $(".green").length
  var red = $(".red").length
  var all = $(".js-student-list").children().length
  var list = $(".student-list")
  var summary = $("<div />")
  if(list){
    summary.append( $("<div class='green summary'>"+green+"</div>") )
    summary.append( $("<div class='yellow summary'>"+yellow+"</div>") )
    summary.append( $("<div class='red summary'>"+red+"</div>") )
    summary.append( $("<div class='all summary'>"+all+"</div>") )
    list.before(summary)
  }
  filter.init()
  $(".summary").on("click", function(event){
    if($(this).hasClass("red"))  
      filter.iso.$element.isotope({filter: ".red"})
    if($(this).hasClass("yellow"))  
      filter.iso.$element.isotope({filter: ".yellow"})
    if($(this).hasClass("green"))  
      filter.iso.$element.isotope({filter: ".green"})
    if($(this).hasClass("all"))  
      filter.iso.$element.isotope({filter: "*"})
  })
})

