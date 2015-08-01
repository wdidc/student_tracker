$(function(){
  $(".js-toggle-grayscale").on("click", function(event){
    $("body").toggleClass("grayscale") 
    toggleGrayscale()
  })
  function toggleGrayscale(){
    if( grayscale() ){
      $("body").removeClass("grayscale") 
      localStorage.setItem("grayscale", "")  
    } else {
      $("body").addClass("grayscale") 
      localStorage.setItem("grayscale", true)  
    }
  }
  function grayscale(){
    var gs = localStorage.getItem("grayscale")
    if(gs){
      $("body").addClass("grayscale") 
    }
    return gs
  }
  grayscale()
})
