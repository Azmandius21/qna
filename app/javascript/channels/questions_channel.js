import consumer from "./consumer"
import questionTemplate from "../templates/question.hbs"

$(document).on("turbolinks:load", function(){
  const questionsList = $(".questions-list")
  const channel = "QuestionsChannel"

  consumer.subscriptions.create(channel, {
    connected(){
      console.log("Questions_channel connected ...")
    },

    received(data){
      console.log(data)
      
      const question = questionTemplate(data)
      questionsList.append(question)
    }
  })   
})

