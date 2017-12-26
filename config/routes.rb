Rails.application.routes.draw do
  resources :users
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :authors do
        resources :books
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
