import consumer from "./consumer"
import template from "../templates/question.handlebars"

consumer.subscriptions.create("QuestionsChannel", {
    connected(){
      console.log("Connected ...")
    },

    received(data){
      $('.questions').append(data)
    }
  }   
)