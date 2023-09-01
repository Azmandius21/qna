import consumer from "./consumer"
import commentTemplate from "../templates/partials/_comment.hbs"

$(document).on("turbolinks:load", function(){
  const table = $(".comments-list")
  const channel = "QuestionsChannel"

  console.log(gon.user_id, gon.user_email)
  // if (channelExist(channel)) return

  consumer.subscriptions.create(channel, {
    connected(){
      console.log("Connected ...")
    },

    received(data){
      console.log(data)
      
      // $('.questions').append(data)
      const comment = commentTemplate(data)
      table.append(question)
      
    }
  })   


})

