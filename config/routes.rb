Danielesplin::Application.routes.draw do

  namespace :api do
    resources :entries
  end

  resources :blog_posts
  resources :comments
  resources :pages
  resources :photos
  resources :searches
  resources :thoughts
  resources :upload_batches
  resources :users

  resources :entries do
    collection do
      get :baby_body
    end
  end

  resources :baby_logs
  match '/baby' => redirect('/baby_logs')

  resources :sessions
  match 'logout', to: 'sessions#destroy', as: 'logout'
  match 'login', to: 'sessions#new', as: 'login'

  # Dir['app/views/pages/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
  #   match "#{page}_page" => "pages##{page}"
  # end

  Dir['app/views/reports/*'].map { |f| File.basename(f, '.html.haml') }.each do |page|
    next if page.starts_with?('_')
    match "#{page}_report" => "reports##{page}"
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
