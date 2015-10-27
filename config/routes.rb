Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "pages#index"
  
  get 'mytrips', to: 'pages#mytrips', as: :mytrips

  resources :plans do
    collection do
      get :search
    end
  end
  
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

    resources :posts
  end

  resources :posts, only: nil do
    resources :comments, only: [:create, :destroy]

    post "downvote", to: 'votes#downvote'
    post "upvote", to: 'votes#upvote'
  end

  get 'mytrips/index/:id/member', to: 'mytrips#member', as: :mytrips_member

  get 'sync/get_provinces'

  get 'sync/get_cities'

  devise_for :users, controllers: {
    registrations: "users/registrations", 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
   get 'index', to: 'posts#index', as: :index
   get 'quotes', to: 'posts#quotes', as: :quotes
end
