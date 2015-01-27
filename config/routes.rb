Puddy::Engine.routes.draw do
  resources :accounts, only: %w(index show)

  resources :transactions, only: %w(index show) do
    get :successful, on: :collection
    get :failed, on: :collection
  end

  root to: 'accounts#index'
end
