import consumer from "./consumer"
import answerTemplate from "../templates/answer.hbs"

$(document).on("turbolinks:load", function(){
  const answersElement = $(".other-answers")
  const question_id = gon.question_id

  consumer.subscriptions.create({
    channel: "QuestionChannel",
    question_id: question_id},
  {
    connected(){
    console.log("Question_channel "+ question_id +" connected ...")
    },

    received(data){
      const answer = answerTemplate(data)
      answersElement.append(answer)
    }
  })   
})

