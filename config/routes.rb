require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  root to: 'questions#index'

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  devise_scope :user do
    post '/email_recipient', to: 'oauth_callbacks#email_recipient'
  end

  concern :votable do
    member do
      patch 'like'
      patch 'dislike'
      patch 'reset'
    end
  end

  concern :commentable do
    member do
      patch 'add_comment'
      delete 'delete_comment'
    end
  end

  resources :questions, concerns: %i[votable commentable] do
    resources :answers, concerns: %i[votable commentable], shallow: true do
      patch 'select', on: :member
    end
    resources :subscriptions, only: %i[create destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: %i[index] do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show create update destroy] do
        resources :answers, only: %i[index show create update destroy], shallow: true
      end
    end
  end

  get '/search', to: 'search#search'

  get 'user/:id', to: 'users#show_rewards', as: 'user_show_rewards'

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  mount ActionCable.server => '/cable'
end
