class AnswersController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def create
    find_question

    @answer = @question.answers.new(answer_params)
    @answer.update(author_id: author.id)

    if @answer.save
      redirect_to @question, notice: 'Your answer created successfully.'
    else
      redirect_to @question, alert: 'The answer body can\'t be blank.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def author
    current_user
  end
end
