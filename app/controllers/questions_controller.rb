class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
    @answers = Answer.all
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
