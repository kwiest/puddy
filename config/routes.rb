Puddy::Engine.routes.draw do
  resources :accounts, only: :show

  resources :transactions, only: %w(index show) do
    get :successful, on: :collection
    get :failed, on: :collection
  end

  root to: 'dashboard#show'
end
