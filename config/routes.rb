Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  root :to => redirect("/users/sign_in")

  resources :posts do
    resources :likes, only: [:create, :edit, :update, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :comments, only: [:create, :edit, :update, :destroy] do
    resources :likes, only: [:create, :edit, :update, :destroy]
  end
end
