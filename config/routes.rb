Rails.application.routes.draw do
  get 'mytrips/index'
  get 'mytrips/index/show/:id', to: 'mytrips#show', as: :mytrips_show

  resources :trips
  # resources :trips do
  #   collection do
  #     get :autocomplete
  #   end
  # end

  resources :groups do
    collection do 
      get :autocomplete
    end
  end
      
  get 'sync/get_provinces'

  get 'sync/get_cities'

  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts
  devise_for :users, controllers: { registrations: "users/registrations", 
             :omniauth_callbacks => "users/omniauth_callbacks" 
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'posts#home'

   get 'index', to: 'posts#index', as: :index
   get 'quotes', to: 'posts#quotes', as: :quotes
   get 'new_plan_step1', to: 'groups#new_plan_step1', as: :new_plan_step1
   get 'new_plan_step2', to: 'groups#new_plan_step2', as: :new_plan_step2
   get 'new_plan_step3', to: 'groups#new_plan_step3', as: :new_plan_step3
   post 'new_plan_create_group', to: 'groups#new_plan_create_group', as: :new_plan_create_group
   get 'new_plan_join_group', to: 'groups#new_plan_join_group', as: :new_plan_join_group

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
end
