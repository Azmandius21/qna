class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show destroy update]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.update(author_id: current_user.id)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
  end

  def destroy
    if author?
      @question.destroy
      redirect_to questions_path, notice: 'The question successfully deleted.'
    else
      redirect_to questions_path, alert: 'Only author of the question can remove it.'
    end
  end

  def update
    if author?
      @question.update(question_params)
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def author?
    current_user.id.eql?(@question.author_id)
  end
end
