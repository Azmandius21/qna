$(document).on('turbolinks:load', function(){
  $('.vote-link').on('ajax:success', function(e){
    const answer = e.detail[0]
    $('.vote-link').toggleClass('hidden');
  
    $('.question-rank').append('<h2>' + answer + '</h2>')
  })
})