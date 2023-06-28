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

  $('form.new-answer').on('ajax:success', function(e){
    const xhr = e.detail[2];
    $('.other-answers').append(xhr.responseText);  
  })
    .on('ajax:error', function(e){
      const xhrEr = e.detail[2];
      $('.answer-errors').html(xhrEr.responseText);
    })
})