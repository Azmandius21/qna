// $(document).on('turbolinks:load', function(){
//   // const gistLinks = $('.gist-link')
//   const gistlinks = $('.show-gist-content')
//   $('.show-gist-content').on('click', getGists)
// });

// function getGists(event){
//   if (event.target.className == "show-gist-content") return
//   event.preventDefault();

//   const gistId = event.target.data('gist-id');
//   const 

//   const {Octokit} = require("@octokit/core");
//   const octokit  = new Octokit(); 

//   jQuery.each(gistLinks, function(){
//     const gistId = $(this).data('gist-id');

//     response = octokit.request("GET /gists/"+ gistId)
//     .then(Gist => { addGistContentToPage(Gist, this)});   
     
//   })
// }

// function addGistContentToPage(result, where){
//   for (file in result.data.files) {
//     var gistContent = "<h3>" + file + "</h3>"
//     gistContent = gistContent + "<div>" + result.data.files[file].content + "</div>"
//     gistContent = "<div class='gist-file'>" + gistContent + "</div>"
//     if (gistContent) {
//       $(where).append(gistContent)
//     }
//   }
// }