Rails.application.routes.draw do
  devise_for :users

  resources :questions do
    resources :answers, shallow: true do
      patch 'select', on: :member
    end
  end

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  root to: 'questions#index'
end
