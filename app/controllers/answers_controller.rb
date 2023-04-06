class AnswersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_answer, only: :show
  before_action :find_question, only: :create

  def create
    @answer = @question.answers.new(answer_params)
    @answer.update(author_id: author.id)

    if @answer.save
      redirect_to @question, notice: 'Your answer created successfully.'
    else
      redirect_to @question, alert: 'The answer body can\'t be blank.'
    end
  end

  def show
    @question = @answer.question   
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])    
  end

  def author
    current_user
  end
end
