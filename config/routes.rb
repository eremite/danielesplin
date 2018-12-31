Danielesplin::Application.routes.draw do

  namespace :api do
    resources :entries
  end

  resources :comments
  resources :entries
  resources :inventory_items
  resources :notes
  resources :pages
  resources :saved_file_categories
  resources :saved_files
  resources :users
  resources :post_photos, only: [:create, :destroy]

  resources :print_batches, only: [:index] do
    collection do
      get :entries
      get :posts
    end
  end

  resources :posts
  get '/blog_posts', to: redirect('/posts')
  get '/blog_posts.rss', to: redirect('/posts.rss')

  resources :photos, except: %i(new)

  resources :sessions
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new', as: 'login'

  # Dir['app/views/pages/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
  #   match "#{page}_page" => "pages##{page}"
  # end

  Dir['app/views/reports/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
    next if page.starts_with?('_')
    match "#{page}_report" => "reports##{page}", via: [:get, :post]
  end

  root :to => 'pages#index'

end
