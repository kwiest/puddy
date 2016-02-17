Puddy::Engine.routes.draw do
  resources :accounts, only: %w(index show) do
    resources :invoices
  end

  resources :payments, only: %w(index show) do
    get :successful, on: :collection
    get :failed, on: :collection
  end

  root to: 'dashboard#show'
end
