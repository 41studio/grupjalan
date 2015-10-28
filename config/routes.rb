Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "pages#index"
  
  get 'mytrips', to: 'pages#mytrips', as: :mytrips

  get 'sync/get_provinces'
  get 'sync/get_cities'

  get 'quotes', to: 'posts#quotes', as: :quotes

  resources :plans do
    collection do
      get :search
    end
  end
  
  resources :trips, only: :show do
    member do
      get "group/:group_id", to: "trips#group", as: :group
      get "group/:group_id/members", to: "trips#members", as: :members_group
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

    resources :posts, except: [:new, :show]
  end

  resources :posts, only: :index do
    resources :comments, only: [:create, :destroy]

    post "downvote", to: 'votes#downvote'
    post "upvote", to: 'votes#upvote'
  end
  
  devise_for :users, controllers: {
    registrations: "users/registrations", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }   
end
