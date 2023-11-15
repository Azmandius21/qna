class QuestionsController < ApplicationController
  include Voted
  include Commented

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show destroy update giving_reward publish_question]
  before_action :find_questions, only: %i[index update]
  after_action :publish_question, only: %i[create]

  authorize_resource

  def index;end

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
    gon.question_id = @question.id

    if @question.best_answer_id
      @best_answer = @question.best_answer
      @answers = @question.answers.where.not(id: @question.best_answer_id)
    else
      @answers = @question.answers
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'The question successfully deleted.'
  end

  def update
    @question.update(question_params)
  end

  def giving_reward(answer); end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id,
                                     files: [],
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

    vote_hash = Hash[
      like_url: like_question_url(@question),
      dislike_url: dislike_question_url(@question),
      reset_url: reset_question_url(@question)
    ]

    attached_files = @question.files&.map do |file|
      {
        file_name: file.filename.to_s,
        file_url: url_for(file)
      }
    end

    links = @question.links&.map do |link|
      if link.gist?
        {
          link_id: link.id,
          gist_id: link.give_gist_id
        }
      else
        {
          link_id: link.id,
          link_url: link.url,
          link_name: link.name
        }
      end
    end

    if @question.reward
      reward = {
        reward_name: @question.reward.name,
        reward_url: url_for(@question.reward.image)
      }
    end

    ActionCable.server.broadcast 'questions_channel',
                                 {
                                   question: { id: @question.id,
                                               vote_rank: Vote.rank_of_votable(@question),
                                               body: @question.body,
                                               title: @question.title,
                                               question_url: question_url(@question),
                                               author_email: @question.author.email,
                                               user_signed_in: "#{current_user ? true : false}",
                                               vote: vote_hash,
                                               attachments: attached_files,
                                               links: links,
                                               reward: reward }
                                 }
  end
end
