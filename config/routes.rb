Rails.application.routes.draw do
  devise_for :users do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end
  root "items#index"
  resources :items
  resources :categories


  resource :cart, only: [:show] do
    post 'increase_quantity', to: 'carts#increase_quantity', as: 'increase_quantity'
    post 'decrease_quantity', to: 'carts#decrease_quantity', as: 'decrease_quantity'
    post 'add/:item_id', to: 'carts#add_to_cart', as: 'add_to'
    delete 'remove/:id', to: 'carts#remove_from_cart', as: 'remove_from'
  end
  
end
