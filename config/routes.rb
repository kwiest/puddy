Puddy::Engine.routes.draw do
  resources :accounts, only: %w(index show) do
    resources :invoices
  end

  get 'accounts/:id/payments' => 'accounts#payments',
    as: 'account_payments'

  resources :payments, only: %w(index show) do
    get :successful, on: :collection
    get :failed, on: :collection
  end

  root to: 'dashboard#show'
end
