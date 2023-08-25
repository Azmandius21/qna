import consumer from "./consumer"
import questionTemplate from "../templates/question.hbs"

$(document).on("turbolinks:load", function(){
  const questionsList = $(".questions-list")
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
      const question = questionTemplate(data)
      questionsList.append(question)
      
    }
  })   


})

