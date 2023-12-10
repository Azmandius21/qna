require 'byebug'

class Api::V1::AnswersController < Api::V1::BaseController
  before_action :set_question, only: %i[index create]

  authorize_resource

  def index
    @answers = @question.answers
    render json: @answers, each_serializer: AnswersSerializer
  end

  def show
    @answer = Answer.find(params[:id])
    render json: @answer, serializer: AnswerSerializer
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.update(author_id: current_user.id)

    if @answer.save
      render json: @answer, status: :created
    else
      render json: { errors: @answer.errors }, status: :bad_request
    end
  end

  def update

  end

  def destroy

  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id)
  end
end
