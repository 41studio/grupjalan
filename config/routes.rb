Rails.application.routes.draw do
  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # users
      post "users/sign_in_email"
      delete "users/sign_out"
      post "users/register"
      get "users/:user_id", to: "users#show"
      put "users/:user_id", to: "users#update"

      # addresses
      get "countries", to: 'addresses#countries'
      get "provinces", to: 'addresses#provinces'
      get "cities", to: 'addresses#cities'

      resources :groups, except: [:edit, :new] do
        collection do
          get "search"
        end

        member do
          get "members"
          get "posts"
        end

        with_options only: [:create, :update, :destroy] do |option|
          option.resources :trips
          option.resources :posts do
            member do
              post "upvote"
              delete "downvote"
            end
          end
        end
      end

      resources :posts, only: nil do
        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end

  # admin
  ActiveAdmin.routes(self)

  # frontend
  root 'pages#index'
  get 'conversations/create'
  get 'conversations/show'
  get 'mytrips', to: 'pages#mytrips', as: :mytrips
  get 'about', to: 'pages#about', as: :about
  get 'sync/get_provinces'
  get 'sync/get_cities'
  get 'inbox', path: 'pesan', to: 'messages#inbox', as: :inbox

  devise_for :users, controllers: {
    registrations: "users/registrations", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :messages, path: 'pesan', only: [:show] do
    collection do
      post "reply/:conversation_id", to: 'messages#reply', as: :reply
      post ":recipient_id", to: 'messages#create', as: :create
      get "recipients"
      get "new/:recipient_id", path: 'baru/:recipient_id', to: 'messages#new', as: :new
    end
  end

  resources :users do
    resources :messages, only: [:index, :create, :destroy] do
      collection do
        get :inbox
      end
    end  
    member do
      get :follow
      get :unfollow
      get :edit_profile
    end
  end
  
  resources :plans, only: [:new, :create] do
    collection do
      get :search
    end
  end

  resources :trips, only: nil do
    collection do 
      get "popular"
    end
  end

  resources :groups, only: [:edit, :update, :show, :index], path: "grup" do
    member do
      post "join"
      delete "leave"
      get "members", path: 'anggota'
      get "about", path: 'tentang'
      get "posts", path: 'postingan'
      get "same", path: 'sama'
      get "fetch_posts", path: 'ajpost'
      get "pribumis", path: 'pribumi'
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

    delete "downvote", to: 'votes#downvote'
    post "upvote", to: 'votes#upvote'
  end

  resources :contacts
  
end
