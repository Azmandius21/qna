class AnswersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_answer, only: %i[show destroy update]
  before_action :find_question_by_id, only: :create
  before_action :find_question, only: %i[destroy show update]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.update(author_id: current_user.id)
  end

  def show; end

  def destroy
    if current_user.id.eql?(@answer.author_id)
      @answer.destroy
      redirect_to question_path(@question), notice: 'The answer deleted successfully.'
    else
      redirect_to @question, alert: 'Only author of the answer can remove it.'
    end
  end

  def update
    if current_user == @answer.author
      @answer.update(answer_params)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id)
  end

  def find_question_by_id
    @question = Question.find(params[:question_id])
  end

  def find_question
    @question = @answer.question
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
