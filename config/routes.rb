Rails.application.routes.draw do

  get "up", to: "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :entries, only: [:create]
  end

  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :decider_lists, only: [:index, :create, :show, :destroy], shallow: true do
    resources :decider_list_items, only: %i[create destroy]
  end
  resources :entries, only: [:index, :create, :edit, :update, :destroy]
  resources :entry_batches, only: %i[new create]
  resources :inventory_items
  resources :notes
  resources :pages, only: [:index]
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :post_photos, only: %i[create destroy]
  resources :post_access_grants, only: %i[create]

  resources :print_batches, only: :index do
    collection do
      get :entries
      get :posts
    end
  end

  resources :posts

  resources :photos, except: %i[new create]
  resources :photo_batches, only: :create

  get 'pick', to: 'decider_list_picker#index'
  get 'pick/:id', to: 'decider_list_picker#new'
  post 'pick/:id', to: 'decider_list_picker#create'

  resources :sessions, only: [:create, :destroy]
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'logout', to: 'sessions#destroy'

  root to: 'pages#index'

end
