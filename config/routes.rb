Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'dashboards#index'
  resource :dashboards, only: [:index] do
    collection do
      get :about_us
      get :contact_us
      post :submit_contact
    end
  end

  resources :galleries do
    collection do
      post :validate_img_name
      post :import
      get :get_image_count
    end
  end

  namespace :api do
    namespace :v1 do
      post 'users/sign_in_user', to: 'users#sign_in_user'
      post 'users/sign_up_user', to: 'users#sign_up_user'
      delete 'users/destroy', to: 'users#destroy'
      post 'users/forgot_password', to: 'users#forgot_password'
      resource :features, only: [:index] do
        collection do
          post :add_image
          post :contact_us_submit
        end
        member do
          get :get_image
        end
      end
    end
  end

    # having created corresponding controller and action
    get '*path', to: 'errors#error_404', via: :all
end
