$(document).on('turbolinks:load', function(){
  const gistShowLinks = $('.show-gist-trigger');
  console.log(gistShowLinks);
  jQuery.each(gistShowLinks, function(){
    $(this).on('custom', function(event){
      event.preventDefault();
      getGist($(this));
    });
    $(this).trigger('custom');
    $(this).hide();
    $(this).off();
  })  
});

function getGist(obj){  
  const  gistId = obj.data('gistId')
  const elementId = obj.data('linkId')
  const element = $('#link-'+ elementId +'-gist-content')

  const { Octokit } = require("@octokit/core")
  const octokit = new Octokit();

  octokit.request("GET /gists/"+ gistId).then(Gist =>{
    addGistContentToPage(Gist, element)
  });
};

function addGistContentToPage(gist,element){
  for (file in gist.data.files){
    let gistContent = "<h3>"+ file +"</h3>"
    gistContent = gistContent + "<div>" + gist.data.files[file].content + "</div>"
    gistContent = "<div class='gist-file'>" + gistContent + "</div>"
    if (gistContent) {
      element.append(gistContent)
    }
  }
}