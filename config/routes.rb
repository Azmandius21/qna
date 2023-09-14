Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  concern :votable do
    member do
      patch 'like'
      patch 'dislike'
      patch 'reset'
    end
  end

  concern :commentable do
    resources :comments, only: %i[destroy]
    member do
      post 'add_comment'
      # delete 'delete_comment/:comment_id'
    end
  end

  resources :questions, concerns: %i[ votable commentable ] do
    resources :answers, concerns: %i[ votable commentable ], shallow: true do

      patch 'select', on: :member
    end
  end

  get 'user/:id', to: 'users#show_rewards', as: 'user_show_rewards'

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  mount ActionCable.server => '/cable'
end
