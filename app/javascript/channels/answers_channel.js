import consumer from "./consumer"
import answerTemplate from "../templates/answer.hbs"

$(document).on("turbolinks:load", function(){
  const answersElement = $(".other-answers")
  const channel = "AnswersChannel"

  // console.log(gon.user_id, gon.user_email)

  consumer.subscriptions.create(channel, {
    connected(){
      console.log("Answers_channel connected ...")
    },

    received(data){
      const answer = answerTemplate(data)
      answersElement.append(answer)
      // $('.new-comment textarea').val('')      
    }
  })   
})

