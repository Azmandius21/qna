import consumer from "./consumer"
import commentTemplate from "../templates/partials/_comment.hbs"

$(document).on("turbolinks:load", function(){
  const channel = "CommentsChannel"

  console.log(gon.user_id, gon.user_email)

  consumer.subscriptions.create(channel, {
    connected(){
      console.log("Coomments_channel connected ...")
    },

    received(data){
      const comment = commentTemplate(data)
      const commented_resource_type = data["comment"]["commentable_type"]
      const commented_resource_id = data["comment"]["commentable_id"]
      const comment_element_id = "#"+commented_resource_type+"-"+commented_resource_id
      const commentsElement = $(comment_element_id).find(".comments-list")
      commentsElement.append(comment)
      $('.new-comment textarea').val('')      
    }
  })   
})

