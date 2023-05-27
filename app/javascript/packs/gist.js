$(document).on('turbolinks:load', function(){
  $('ul li a').on('click', function(e){
   e.preventDefault();
   // gist-client entity
   const GistClient = require("gist-client")
   const gistClient = new GistClient()
   // parsing url
   const url = new URL(this.href)
   const urlPattern = url.username + url.hostname 
   if (urlPattern == 'gist.github.com') {
    $(this).toggle();   
    gistClient.getOneById('GIST_ID') 
   }
   
   console.log(url.search)
   console.log(gistClient)
  });
})