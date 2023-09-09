$(document).on('turbolinks:load', function(){
  $('.question-edit-hide-form').on('ajax:success','.vote-link', function(e){
    const rank = e.detail[0][1]
    const votableId = e.detail[0][0]
    const votableClass = e.detail[0][2]
    const newUrl = '/'+ votableClass +'/'+ votableId + '/reset.json'

    $('#'+votableId+'.vote-link').toggleClass('hidden');
    $('#'+votableId+'.votable-rank').html(rank)
    $('#'+votableId+'.reset').attr("href", newUrl)
  })
})