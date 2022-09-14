Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    get "search" => "searches#search"
    get "users/check" => "users#check"
    patch 'users/delete' => "users#delete"
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :events, only: [:new, :create, :update, :index, :show, :edit] do
      resources :comments, only: [:create, :destroy]
      resource :joins, only: [:create, :destroy]
    end
    resources :genres, only: [:show]
    resources :notifications, only: [:index, :destroy]
  end

  namespace :admin do
    get '/' => "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :events, only: [:index, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :show]
  end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
