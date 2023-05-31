$(document).on('turbolinks:load', function(){
  gistLinks = $('ul li .gist-link')
   
   // parsing url
   const url = new URL(this.href)
   const urlPattern = url.username + url.hostname 
   const gistId = url.hash
   const arr = url.pathname.split('/')
   if (urlPattern == 'gist.github.com') {
    //$(this).toggle();
    console.log('begin')
    console.log(arr[2])
    console.log('end')
   }
   //console.log(gistClient)
  });
})