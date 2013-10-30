Betastore::Application.routes.draw do
  namespace :admin do
    resources :products
  end

  root :to => 'subscriptions#index'

  resources :subscriptions
  resources :products

  get '/sign_up' => 'customers#new', as: 'sign_up'
  post '/sign_up' => 'customers#create'

  get "/orders/new"

  get '/log_in' => 'log_ins#new', as: 'log_in'
  post '/log_in' => 'log_ins#create'
  post '/log_out' => 'log_ins#destroy', as: 'log_out'

  get '/forgot_password' => 'password_resets_controller#new', as: 'forgot_password'
  post '/forgot_password' => 'password_resets_controller#create'

  get '/reset_password/:id/:token' => 'password_resets_controller#edit', as: 'reset_password'
  post '/reset_password/:id/:token' => 'password_resets_controller#update'
end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
