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
  resources :thoughts
  resources :users

  resources :print_batches, only: [:index] do
    collection do
      get :print
    end
  end

  resources :posts
  get '/blog_posts', to: redirect('/posts')
  get '/blog_posts.rss', to: redirect('/posts.rss')

  resources :photos do
    collection do
      get :old_new
    end
  end

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
