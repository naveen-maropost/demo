Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'dashboards#index'
  resource :dashboards do
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
    end
  end
end
