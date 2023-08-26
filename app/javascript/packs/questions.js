$(document).on('turbolinks:load', function(){
  $('.question-edit-hide-form').on('click','.edit-question-link', function(e){
   e.preventDefault();
   $(this).hide();
   const questionId= $(this).data('questionId');   
   $('form#edit-question-'+ questionId).removeClass('hidden');
  })
})