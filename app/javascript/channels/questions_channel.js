import consumer from "./consumer"
import template from "../templates/question.handlebars"

consumer.subscriptions.create("QuestionsChannel", {
    connected(){
      console.log("Connected ...")
    },

    received(data){
      console.log(data)
      // $('.questions').append(data)
    }
  }   
)