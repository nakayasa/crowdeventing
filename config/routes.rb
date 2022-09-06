Rails.application.routes.draw do

# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    resources :users, only: [:index, :show, :edit, :update]
      post 'users/check'
      get 'users/my_page' => 'users#show'
      get 'users/information/edit' => 'users#edit'
      patch 'users/information' => 'users#update'
    resources :events, only: [:new, :index, :show, :edit]
      #検索用get "search" => "searches#search"
    resources :genres, only: [:show]
  end

  namespace :admin do
  get '/' => "homes#top"
  resources :users, only: [:index, :show, :edit, :update]
  resources :events, only: [:index, :show, :edit, :update, :destroy]
  resources :genres, only: [:index, :create, :edit, :update]
  end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
