$(document).on('turbolinks:load', function(){

  $('.comments-list').on('ajax:success', '.remove-comment-link',
    function(e){
      const commentId = e.detail[0].id
      const comment =$('#'+ commentId + '.comment')
      comment.html('')
    })
})