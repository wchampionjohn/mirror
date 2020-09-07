Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :admin do
      root 'admin/index#index'
      resources :devices do
      end
    end
end
