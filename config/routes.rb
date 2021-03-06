Rails.application.routes.draw do

  namespace :api do
    resources :entries
  end

  resources :comments
  resources :decider_lists, only: %i[index show], shallow: true do
    resources :decider_list_items, only: %i[new create destroy]
  end
  resources :entries
  resources :inventory_items
  resources :notes
  resources :pages
  resources :saved_file_categories
  resources :saved_files
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
  get '/posts.rss', to: 'visible_posts#index'
  get '/blog_posts', to: redirect('/posts')
  get '/blog_posts.rss', to: redirect('/posts.rss')

  resources :photos, except: %i(new)

  get 'pick', to: 'decider_list_picker#index'
  get 'pick/:id', to: 'decider_list_picker#new'
  post 'pick/:id', to: 'decider_list_picker#create'

  resources :sessions
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new', as: 'login'

  root to: 'pages#index'

end
