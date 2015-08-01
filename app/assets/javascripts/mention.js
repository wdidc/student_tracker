$(function(){
  function getUsers(callback){
    $.getJSON("/users", function( users ){
      callback(users) 
    })
  }
  getUsers(function(users){
    $('textarea.mention').mentionsInput({
      onDataRequest:function (mode, query, callback) {
	var data = []
        users.forEach(function(user){
          data.push({
            id: user.id,
	    name: user.login,
            fullName: user.name,
	    avatar: user.avatar_url,
            type: ""
          })
	}) 
	data = _.filter(data, function(item) { return item.name.toLowerCase().indexOf(query.toLowerCase()) > -1 })
	callback.call(this, data)
      }
    });
  })
})