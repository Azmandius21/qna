$(document).on('turbolinks:load', function(){
  
  let gistLinks = $('.gist-link')
  const token = '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'

  const GistClient = require("gist-client")
  const gistClient = new GistClient()
  gistClient.setToken(token)
  jQuery.each(gistLinks, function(){
    const gistId = $(this).data('gist-id');
    gistClient.getOneById(gistId).then(
     Gist => {
      const gist = Gist
      const gistFile = gist['files']['gistfile1.txt']
      const gistFileName = gist['files']['gistfile1.txt']['filename']
      const content = gistFile['content']
      const owner = gist['owner']['login']
     
      $(this).append("<div class='gist'>\
                        <div class='title'>Title:"+ Gist.description +"</div>\
                        <div class='file-name'>File name:"+ gistFileName +"</div>\
                        <div class='context'>Content:"+ content +"</div>\
                        <div class='owner'>Owner:"+ owner +"</div>\
                     </div>")     
    })
  })
})
