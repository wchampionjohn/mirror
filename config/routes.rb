Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root 'admin/index#index'
    resources :devices

    resources :stores do
      scope module: :stores do
        resources :introductions, only: [:index, :create, :destroy]
      end
    end

    resources :ads do
      scope module: :ads do
        resources :files, only: [:create]
      end
    end

    resources :auditing_ads, only: [:index] do
      collection do
        post :batch_approve
      end
      scope module: :auditing_ads do
        member do
          resource :judgement, only: [:create, :destroy]
          resource :wait, only: [:create]
        end
      end
    end
    resources :tmp_files
  end

  resources :cities, only:[] do
    scope module: :cities do
      member do
        resources :areas, only:[:index]
      end
    end
  end
end
