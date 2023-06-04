$(document).on('turbolinks:load', function(){
  let gistLinks = $('.gist-link')
  
  console.log(gistLinks) 

  jQuery.each(gistLinks, function(){
    //alert($(this).data('url'));
    const url = $(this).data('url');
    $('p',{
      src: "${url}"
    }).appendTo(this)
    $(this).innerHTML('<script src="https://gist.github.com/Azmandius21/eff05f500691a63d7dd0cdec1ab895ca.js"></script>')
  })
  // // for use Gist-Client
  // const GistClient = require("gist-client")
  // const gistClient = new GistClient()
  // //

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