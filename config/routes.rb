Rails.application.routes.draw do
  root to: 'menu_items#index'
  get '/contact_us' => 'contact_us#index'
  resources :menu_items
  resources :orders
  post '/orders/add_item/:id' => 'orders#add_item'
end
