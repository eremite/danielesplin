Danielesplin::Application.routes.draw do

  constraints(host: /nutritionalbites/) do
    get '/', to: 'public_nutritional_posts#index', as: 'public_nutritional_posts'
    get '/:id', to: 'public_nutritional_posts#show', as: 'public_nutritional_post'
  end

  namespace :api do
    resources :entries
  end

  resources :blog_posts
  resources :comments
  resources :entries
  resources :nutritional_posts
  resources :pages
  resources :saved_file_categories
  resources :saved_files
  resources :thoughts
  resources :upload_batches
  resources :users

  resources :photos do
    collection do
      get :old_new
    end
    member do
      put :reprocess
    end
  end

  resources :sessions
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: 'login'

  # Dir['app/views/pages/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
  #   match "#{page}_page" => "pages##{page}"
  # end

  Dir['app/views/reports/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
    next if page.starts_with?('_')
    match "#{page}_report" => "reports##{page}", via: [:get, :post]
  end

  root :to => 'pages#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
