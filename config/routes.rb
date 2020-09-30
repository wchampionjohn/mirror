Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        resources :devices, only: [:show], param: :key do
          scope module: :devices do
            member do
              resources :touch, only: [:create]
              resources :version, only: [:create]
            end
          end

          resources :channels, only: [:show] do
            scope module: :channels do
              resources :programs, only: [:index]
            end
          end

        end
    end
  end

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

    resources :channels do
      scope module: :channels do
        resources :programs, only: [:index, :update, :create, :destroy] do
          member do
            post :screenshot
            put :suspend
            put :recover
          end
          collection do
            put :rearrange
          end
        end
      end
    end

    resources :tmp_files
    resources :global_settings, only: [:index, :edit, :update]
  end


  resources :cities, only:[] do
    scope module: :cities do
      member do
        resources :areas, only:[:index]
      end
    end
  end
end
