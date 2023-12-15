class Api::V1::AnswersController < Api::V1::BaseController
  before_action :set_question, only: %i[index create]
  before_action :set_answer, only: %i[show update destroy]

  authorize_resource

  def index
    @answers = @question.answers
    render json: @answers, each_serializer: AnswersSerializer
  end

  def show
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
    if @answer.update(answer_params)
      render json: @answer, status: :accepted
    else
      render json: { errors: @answer.errors }, status: :bad_request
    end
  end

  def destroy
    byebug
    if @answer.destroy
      head :accepted
    else
      render json: { errors: @answer.errors }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:id, :body, :question_id, :author_id)
  end
end
