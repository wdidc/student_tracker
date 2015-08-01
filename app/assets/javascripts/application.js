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
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(function(){
  var yellow = $(".yellow").length
  var green = $(".green").length
  var red = $(".red").length
  var all = $(".js-student-list").children().length
  var list = $(".student-list")
  var summary = $("<div />")
  if(list){
    summary.append( $("<div data-filter='*' class='all summary'>"+all+"</div>") )
    summary.append( $("<div data-filter='green' class='green summary'>"+green+"</div>") )
    summary.append( $("<div data-filter='yellow' class='yellow summary'>"+yellow+"</div>") )
    summary.append( $("<div data-filter='red' class='red summary'>"+red+"</div>") )
    list.before(summary)
  }
  filter.init()
  $(".summary").on("click", function(event){
      var filterBy = this.getAttribute('data-filter') == "*" ? "*" : "." + this.getAttribute('data-filter') 
      window.location.hash = "/" + filterBy
  })
  $(".notification input").on("change", function(){
    var $form = $(this).closest("form")
    var url = $form.attr("action")
    var isRead = $form.find("#notification_read").is(':checked')
    $(".meta").attr("data-read", isRead)
    var count = $(".notification-count").attr("data-notifications-count")
    isRead ? count-- : count++
    $(".notification-count").attr("data-notifications-count", count)
    $.ajax({
      url: url,
      dataType: "json",
      method: "patch",
      data: {
        notification: {
          read: isRead 
	}
      },
      success: function( response ){
        console.log(response)
      }
    })
  })
})

