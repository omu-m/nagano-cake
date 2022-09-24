Rails.application.routes.draw do

  # devise_for :admins
  # devise_for :customers

  # 管理者側
  namespace :admin do
    get "/" => "homes#top"
    resources :orders
    resources :customers
    resources :genres
    resources :items
  end

  # 会員側
  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resources :addresses
    resources :orders
    resources :cart_items
    resources :items
    get "/customers/mypage" => "customers#show"
    get "/customers/mypage/edit" => "customers#edit"
    get "/customers/unsubscribe" => "customers#unsubscribe"
    get "/customers/withdrawal" => "customers#withdrawal"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 会員側
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者側
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end
