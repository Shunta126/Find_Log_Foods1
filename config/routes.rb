Rails.application.routes.draw do
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'customers', to: 'customers#index'
  get 'customers/:id/my_page', to: 'customers#show', as: 'customer'
  get 'customers/:id/information/edit', to: 'customers#edit', as: 'edit_customer'
  patch 'customers/:id/information', to: 'customers#update', as: 'update_customer'
  get 'customers/:id/confirm', to: 'customers#confirm', as: 'confirm_customer'
  patch 'customers/:id/withdrawal', to: 'customers#withdrawal', as: 'withdrawal_customer'
  get "search" => "searches#search"
  resources :restaurants do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :likes, only: [:index]
end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: 'homes#top'
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:show, :edit, :update]
  resources :restaurants, only: [:index, :show, :edit, :destroy, :update]
 end
end
