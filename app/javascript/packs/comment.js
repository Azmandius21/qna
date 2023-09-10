$(document).on('turbolinks:load', function(){
  // $( "form.new-comment").on('ajax:success', function(e){
  //   const commentableType = e.detail[0]['commentable_type'].val().toLowerCase()
  //   const commentableId = e.detail[0]['commentable_id']
  //   const comment = e.detail[2]

  //   $('#'+ commentableType + '-' + commentableId +'.comment-list.container').append(comment)
  // })
  $('.comments-list').on('ajax:success', '.remove-comment-link',
    function(e){
      const commentId = e.detail[0].id
      const comment =$('#'+ commentId + '.comment')
      comment.html('')
    })
})