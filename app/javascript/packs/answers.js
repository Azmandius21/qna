$(document).on('turbolinks:load', function(){
  $('.answers').on('click','.edit-answer-link', function(e){
   e.preventDefault();
   $(this).hide();
   const answerId= $(this).data('answerId');
   $('form#edit-answer-'+ answerId).removeClass('hidden');
  });

  $('.answers').on('click', '.delete-answer-link', function(e){
    const answerId = $(this).data('answerId');
    $('.answer-'+ answerId).remove();
  });

  $('.other-answers').on('click', '.best-answer-link', function(e){
    const answerId = $(this).data('answerId');
    const lastBestAnswer = $(this)
  
    $('.answer'+ answerId).remove();
    $('.best-answer').html('.answer' + answerId);
  })
})