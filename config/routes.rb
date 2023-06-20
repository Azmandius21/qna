Rails.application.routes.draw do
  devise_for :users

  get 'user/:id', to: 'users#show_rewards', as: 'user_show_rewards'

  resources :questions do
    resources :answers, shallow: true do
      patch 'select', on: :member
    end
  end

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  root to: 'questions#index'
end
