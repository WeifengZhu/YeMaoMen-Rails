Yemaomen::Application.routes.draw do

  resources :users, only: [:create, :update, :destroy]
  match '/users/info', to: 'users#update', via: :post
  match '/users', to: 'users#destroy', via: :delete
  match '/top_users', to: 'users#top_users', via: :get

  resources :sessions, only: [:create]
  resources :topics, only: [:index, :create, :destroy]
  resources :posts, only: [:top_posts, :create, :destroy, :index, :update]
  match '/top_posts', to: 'posts#top_posts', via: :get
  # :destroy_all可以不加入resources的only:列表中，当然，加进去也没什么问题。
  match '/posts', to: 'posts#destroy_all', via: :delete
  match '/posts_by_like_count', to: 'posts#posts_by_like_count', via: :get
  match '/my_posts', to: 'posts#my_posts', via: :get
  match '/my_posts_by_like_count', to: 'posts#my_posts_by_like_count', via: :get

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
