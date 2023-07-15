$(document).on('turbolinks:load', function(){
  $('.vote-link').on('ajax:success', function(e){
    const answer = e.detail[0][1]
    const voteId = e.detail[0][0].id
    const votableId = $(this).data('id')
    const newUrl = '/votes/'+ voteId + '/destroy.json'

    $('#'+votableId+'.vote-link').toggleClass('hidden');
    $('#'+votableId+'.votable-rank').html('<h2>' + answer + '</h2>')
    $('#'+votableId+'.reset').attr("href", newUrl)
  })
})