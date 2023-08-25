$(document).on('turbolinks:load', function(){
  $('.questions-list').on('ajax:success', function(e){
    const rank = e.detail[0][1]
    const votableId = e.detail[0][0]
    const newUrl = '/questions/'+ votableId + '/reset.json'

    $('#'+votableId+'.vote-link').toggleClass('hidden');
    $('#'+votableId+'.votable-rank').html('<p>' + rank + '</p>')
    $('#'+votableId+'.reset').attr("href", newUrl)
  })
})