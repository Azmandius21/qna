require 'byebug'
class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionsSerializer
  end

  def show
    # byebug
    @question = Question.find(params[:id])
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

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id,
                                     links_attributes: %i[id name url _destroy])
  end
end
