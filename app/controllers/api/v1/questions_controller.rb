class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :find_question, only: %i[ show update destroy]

  authorize_resource

  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionsSerializer
  end

  def show
    render json: @question, serializer: QuestionSerializer
  end

  def create
    @question = current_resource_owner.questions.build(question_params)
    if @question.save
      render json: @question, status: :created
    else
      render json: { errors: @question.errors }, status: :bad_request
    end
  end

  def update
    if @question.update(question_params)
      render json: @question, status: :accepted
    else
      render json: { errors: @quetion.errors}, status: :bad_request
    end
  end

  def destroy
    if @question.destroy
      head :accepted
    else
      render json: { errors: @question.errors }
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id,
    links_attributes: %i[id name url _destroy])
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
