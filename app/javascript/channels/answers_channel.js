import consumer from "./consumer"
import answerTemplate from "../templates/answer.hbs"

$(document).on("turbolinks:load", function(){
  const answersElement = $(".other-answers")
  const questionId = $('.question-show-content').attr('id')
  const question_id = gon.question_id

  console.log(questionId, question_id)

  consumer.subscriptions.create({
    channel: "AnswersChannel",
    question_id: questionId},
  {
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

