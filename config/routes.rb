Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "pages#index"
  
  resources :plans do
    collection do
      get :search
    end
  end
  
  get 'mytrips', to: 'pages#mytrips', as: :mytrips
  get 'mytrips/index/show/:id', to: 'mytrips#show', as: :mytrips_show
  post 'mytrips/index/show/:id', to: 'mytrips#create_post', as: :mytrips_create_post
  get 'mytrips/index/:id/member', to: 'mytrips#member', as: :mytrips_member
  get 'mytrips_join_group', to: 'mytrips#mytrips_join_group', as: :mytrips_join_group
  get 'mytrips_leave_group', to: 'mytrips#mytrips_leave_group', as: :mytrips_leave_group
  post 'create_comment/:id', to: 'posts#create_comment', as: :comment_create
  delete 'delete_comment', to: 'posts#destroy_comment', as: :delete_comment

  resources :trips do
    member do
      get "group/:group_id", to: "trips#group", as: :group
    end
  end

  resources :groups do
    member do
      post "join"
      delete "leave"
    end

    collection do 
      get :autocomplete
    end
  end
      
  get 'sync/get_provinces'

  get 'sync/get_cities'

  
  resources :posts do 
    member do
     get "like", to: "posts#upvote"
     get "dislike", to: "posts#downvote"
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations", 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
   get 'index', to: 'posts#index', as: :index
   get 'quotes', to: 'posts#quotes', as: :quotes
   get 'new_plan_step1', to: 'groups#new_plan_step1', as: :new_plan_step1
   get 'new_plan_step2', to: 'groups#new_plan_step2', as: :new_plan_step2
   get 'new_plan_step3', to: 'groups#new_plan_step3', as: :new_plan_step3
   post 'new_plan_create_group', to: 'groups#new_plan_create_group', as: :new_plan_create_group
   get 'new_plan_join_group', to: 'groups#new_plan_join_group', as: :new_plan_join_group
end
