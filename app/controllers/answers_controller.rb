class AnswersController < ApplicationController
  def create
    find_question
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question, notice: 'Your answer created successfully.'
    else
      redirect_to @question, alert: 'The answer body can\'t be blank.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
