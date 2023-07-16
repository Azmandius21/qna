class AnswersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_answer, only: %i[show destroy update select]
  before_action :find_question_by_id, only: :create
  before_action :find_question, only: %i[destroy show update select]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.update(author_id: current_user.id)

    respond_to do |format|
      if @answer.save
        format.html { render @answer }
      else
        format.html { render partial: 'shared/errors', locals: { resource: @answer }, status: '422' }
      end
    end
  end

  def show; end

  def destroy
    if current_user.author?(@answer)
      @answer.destroy
      redirect_to question_path(@question), notice: 'The answer deleted successfully.'
    end
  end

  def update
    @answer.update(answer_params) if current_user.author?(@answer)
    @best_answer = @question.best_answer
    @other_answers = @best_answer ? @question.answers.where.not(id: @best_answer.id) : @question.answers
  end

  def select
    if current_user.author?(@question)
      @answer.mark_as_best
      @best_answer = @answer
      @other_answers = @question.answers.where.not(id: @answer.id)
      flash[:notice] = 'Best answer selected'
    else
      flash[:alert] = 'Select best answer can only question author'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id, files: [],
                                                                    links_attributes: %i[id name url _destroy])
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
