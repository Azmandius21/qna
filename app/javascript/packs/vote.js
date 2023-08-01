$(document).on('turbolinks:load', function(){
  $('.vote-link').on('ajax:success', function(e){
    const answer = e.detail[0][1]
    const voteId = e.detail[0][0].id
    const votableId = $(this).data('id')
    const newUrl = '/votes/'+ voteId + '/destroy.json'

    $('#'+votableId+'.vote-link').toggleClass('hidden');
    $('#'+votableId+'.votable-rank').html('<h4>' + answer + '</h4>')
    $('#'+votableId+'.reset').attr("href", newUrl)
  })
})