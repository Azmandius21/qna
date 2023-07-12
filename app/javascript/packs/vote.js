$(document).on('turbolinks:load', function(){
  $('.vote-link').on('ajax:success', function(e){
    const answer = e.detail[0][1]
    const voteId = e.detail[0][0].id
    const newUrl = '/votes/'+ voteId + '/destroy.json'

    $('.vote-link').toggleClass('hidden');

    $('.votable-rank').html('<h2>' + answer + '</h2>')
    $('.reset').attr("href", newUrl)
  })
})