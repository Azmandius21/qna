Rails.application.routes.draw do
  devise_for :users

  get 'user/:id', to: 'users#show_rewards', as: 'user_show_rewards'

  resources :questions do
    resources :answers, shallow: true do
      patch 'select', on: :member
    end
  end

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  post   'questions/:question_id/votes/', to: 'votes#create', as: 'create_vote_to_question'
  post   'answers/:answer_id/votes/', to: 'votes#create', as: 'create_vote_to_answer'
  delete 'votes/:id/destroy', to: 'votes#destroy', as: 'destroy_vote'

  root to: 'questions#index'

  mount ActionCable.server => '/cable'
end
