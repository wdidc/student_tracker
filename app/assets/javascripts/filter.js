var filter = {
  listen: function(){
    this.input.addEventListener("keyup", function(event){
      window.location.hash = "/" + event.target.value
    }.bind(this))
    window.onhashchange = function(event){
      this.input.value = window.location.hash.substr(2)
      this.iso.$element.isotope({filter: this.filter})
    }.bind(this)
  },
  filter: function(){
    if(filter.input.value){
      for( var i = 0; i < this.classList.length; i++ ){
        var klass = this.classList[i]
        if(klass.match(filter.input.value))
          return true
      }
    } else {
      return true
    }
  },
  init: function(){
    this.input = document.querySelector(".js-filter")
    this.input.value = window.location.hash.substr(2)
    this.input.setSelectionRange(1000,1000)
    this.iso = new Isotope( '.js-student-list', {
	itemSelector: 'p',
	layoutMode: 'fitRows'
    })
    this.listen()
  }
}

