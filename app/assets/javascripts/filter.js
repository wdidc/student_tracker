var filter = {
  listen: function(){
    this.input.focus()
    this.input.addEventListener("keyup", function(event){
      window.location.hash = "/" + event.target.value
    }.bind(this))
    window.onhashchange = function(event){
      this.input.value = window.location.hash.substr(2)
      this.iso.$element.isotope({filter: this.filter})
    }.bind(this)
  },
  filter: function(){
    var value = filter.input.value
    if(value == "*")
      value = ""
    if(value){
      for( var i = 0; i < this.classList.length; i++ ){
        var klass = this.classList[i]
	classValue = value.match(/\./) ? value.substr(1) : value
        if(klass.match(classValue)){
          return true
	}
      }
      if(value.match(/\./))
	return
      var words = this.querySelector("a").innerText.split(" ")
      for( var i = 0; i < words.length; i++ ){
        var word = words[i]
	var re = new RegExp(value,"i")
        if(word.match(re)){
          return true
	}
      }
    } else {
      return true
    }
  },
  init: function(){
    this.input = document.querySelector(".js-filter")
    this.input.value = window.location.hash.substr(2)
    this.input.setSelectionRange(1000,1000)
    var container = document.querySelector(".js-student-list")
    if(container){
      this.iso = new Isotope( '.js-student-list', {
	  itemSelector: 'p',
	  layoutMode: 'fitRows'
      })
      this.iso.$element.isotope({filter: this.filter})
      this.listen()
    }
  }
}

