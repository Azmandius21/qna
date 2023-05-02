class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show destroy update]
  before_action :find_questions, only: %i[index update]
  def index; end

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
    if current_user.author?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'The question successfully deleted.'
    else
      redirect_to questions_path, alert: 'Only author of the question can remove it.'
    end
  end

  def update
    if current_user.author?(@question)
      @question.update(question_params)
    else
      redirect_to questions_path, alert: 'Only author of the question can edit it.'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def find_questions
    @questions = Question.all
  end
end
