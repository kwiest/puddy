Puddy::Engine.routes.draw do
  resources :accounts, only: %w(index show)

  root to: 'accounts#index'
end
