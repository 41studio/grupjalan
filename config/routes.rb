Rails.application.routes.draw do
  get 'conversations/create'

  get 'conversations/show'


  # devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: {
    registrations: "users/registrations", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }   

  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # users
      post "users/sign_in_email"
      delete "users/sign_out"
      post "users/register"
      get "users/:user_id", to: "users#show"
      put "users/:user_id", to: "users#update"

      resources :groups, except: [:edit, :new] do
        collection do
          get "search"
        end
      end

      resources :trips, only: :index
    end
  end

  # You can have the root of your site routed with "root"
   resources :users do
    resources :messages, only: [:index, :create, :destroy] do
      collection do
        get :inbox
      end
    end  
    member do
      get :follow
      get :unfollow
    end
   end
   # root 'posts#home'

   get 'index', to: 'posts#index', as: :index
   get 'current_user_show', to: 'posts#current_user_show', as: :current_show
   get 'show_profile',   to: 'posts#show_profile', as: :show_profile
   get 'new_plan_step1', to: 'groups#new_plan_step1', as: :new_plan_step1
   get 'new_plan_step2', to: 'groups#new_plan_step2', as: :new_plan_step2
   get 'new_plan_step3', to: 'groups#new_plan_step3', as: :new_plan_step3
   post 'new_plan_create_group', to: 'groups#new_plan_create_group', as: :new_plan_create_group
   get 'new_plan_join_group', to: 'groups#new_plan_join_group', as: :new_plan_join_group
  ActiveAdmin.routes(self)

  root "pages#index"
  
  get 'mytrips', to: 'pages#mytrips', as: :mytrips

  get 'sync/get_provinces'
  get 'sync/get_cities'

  get 'quotes', to: 'posts#quotes', as: :quotes

  resources :plans, only: [:new, :create] do
    collection do
      get :search
    end
  end

  
  resources :trips, only: nil do
    member do
      # get "group/:group_id", to: "trips#group", as: :group
      # get "group/:group_id/members", to: "trips#members", as: :members_group
    end
    collection do 
      get "popular"
    end
  end

  resources :groups, only: [:edit, :update, :show], path: "grup" do
    member do
      post "join"
      delete "leave"
      get "members", path: 'anggota'
      get "about", path: 'tentang'
      get "posts", path: 'postingan'
    end

    collection do 
      get :autocomplete
    end

    resources :trips, only: :show do
      member do 
        delete "leave"
        post "join"
        get "members"
      end
    end

    resources :posts, except: [:new, :show]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]

    post "downvote", to: 'votes#downvote'
    post "upvote", to: 'votes#upvote'
  end
  
end
