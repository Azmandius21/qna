$(document).on('turbolinks:load', function(){
  let gistLinks = $('.gist-link')
  const token = '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'
  console.log(gistLinks) 

  const GistClient = require("gist-client")
  const gistClient = new GistClient()
  gistClient.setToken(token)
  jQuery.each(gistLinks, function(){
    const gistId = $(this).data('gist-id');
    gistClient.getOneById(gistId)
    //alert($(this).data('url'));
  })
})




// parsing url
//  const url = new URL(this.href)
//  const urlPattern = url.username + url.hostname 
//  const gistId = url.hash
//  const arr = url.pathname.split('/')
//  if (urlPattern == 'gist.github.com') {
 //$(this).toggle();
 // console.log(arr[2])
 // console.log('end')

//console.log(gistClient)