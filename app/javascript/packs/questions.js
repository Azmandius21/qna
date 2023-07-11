$(document).on('turbolinks:load', function(){
  $('.questions').on('click','.edit-question-link', function(e){
   e.preventDefault();
   $(this).hide();
   const questionId= $(this).data('questionId');   
   $('form#edit-question-'+ questionId).removeClass('hidden');
  })

  // $('.vote-link').on('ajax:success', function(e){
  //   const answer = e.detail[0];
  //   $('.vote-link').toggleClass('hidden');
  //   $('.reset-vote').toggleClass('hidden')
  //   $('.question-rank').append('<h2>' + answer + '</h2>')
  // })

  // $('.cancel-vote-link').on('ajax:success', function(e){
  //   const answer = e.detail[0];
  //   $('.vote-link').removeClass('hidden');
  //   $('.cancel-vote-link').addClass('hidden')
  //   $('.question-rank').append('<h2>' + answer + '</h2>')
  // })
})