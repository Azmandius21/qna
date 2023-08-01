require 'byebug'
class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show destroy update giving_reward publish_question]
  before_action :find_questions, only: %i[index update]

  after_action :publish_question, only: %i[ create destroy]

  def index; end

  def new
    @question = Question.new
    @question.links.build
    @question.build_reward
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
    @answer.links.build
    if @question.best_answer_id
      @best_answer = @question.best_answer
      @answers = @question.answers.where.not(id: @question.best_answer_id)
    else
      @answers = @question.answers
    end
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

  def giving_reward(answer); end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id, files: [],
                                                                links_attributes: %i[id name url _destroy],
                                                                reward_attributes: %i[name image])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def find_questions
    @questions = Question.all
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast "questions_channel", 
      ApplicationController.render(
        partial: "questions/question",
        locals: { question: @question}
      )
  end
end
