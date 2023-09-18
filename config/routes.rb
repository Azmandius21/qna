Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks'}

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
  end

  get 'user/:id', to: 'users#show_rewards', as: 'user_show_rewards'

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  mount ActionCable.server => '/cable'
end
