Rails.application.routes.draw do

  get "up", to: "rails/health#show", as: :rails_health_check

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
  resources :posts
  resources :post_access_grants, only: %i[create]
  resources :photos, only: %i[index edit update destroy]
  resources :photo_batches, only: :create

  resources :print_batches, only: :index do
    collection do
      get :entries
      get :posts
    end
  end

  namespace :api do
    resources :entries, only: [:create]
  end

  get 'pick', to: 'decider_list_picker#index'
  get 'pick/:id', to: 'decider_list_picker#new'
  post 'pick/:id', to: 'decider_list_picker#create'
  get 'ff', to: 'photo_frames#index'
  get 'ff/:id', to: 'photo_frames#show'

  resources :sessions, only: [:create, :destroy]
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'logout', to: 'sessions#destroy'

  root to: 'pages#index'

end
