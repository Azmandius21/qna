import consumer from "./consumer"
import commentTemplate from "../templates/partials/_comment.hbs"

$(document).on("turbolinks:load", function(){
  const commentsElement = $(".comments-list .container")
  const channel = "CommentsChannel"

  console.log(gon.user_id, gon.user_email)

  consumer.subscriptions.create(channel, {
    connected(){
      console.log("Coomments_channel connected ...")
    },

    received(data){
      const comment = commentTemplate(data)
      commentsElement.append(comment)
      $('.new-comment textarea').val('')      
    }
  })   
})

