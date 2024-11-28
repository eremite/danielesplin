Rails.application.routes.draw do

  get "up", to: "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :entries
  end

  resources :comments
  resources :decider_lists, shallow: true do
    resources :decider_list_items, only: %i[new create destroy]
  end
  resources :entries
  resources :inventory_items
  resources :notes
  resources :pages
  resources :users
  resources :post_photos, only: %i[create destroy]

  resources :print_batches, only: :index do
    collection do
      get :entries
      get :posts
    end
  end

  resources :posts
  resources :visible_posts, only: :index

  resources :photos, except: %i[new create show]
  resources :photo_batches, only: :create

  get 'pick', to: 'decider_list_picker#index'
  get 'pick/:id', to: 'decider_list_picker#new'
  post 'pick/:id', to: 'decider_list_picker#create'

  resources :sessions
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new', as: 'login'

  root to: 'pages#index'

end
