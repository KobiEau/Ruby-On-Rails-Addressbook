Rails.application.routes.draw do
  devise_for :users,controllers:{
      #tell devise to use this custom controller
      registrations: "users/registrations"
    }
  
  get "pages/home"
  root "pages#home"
 
  namespace :admin do
    root "dashboard#index"
    resources :error_logs, only: [:index, :destroy]
    resources :users do
      collection do
        delete :bulk_destroy
        get :export_selected
      end
      member do
        patch :lock
        patch :unlock
      end
    end
    resources :contacts do
      collection do
        delete :bulk_destroy
        get :export_selected
      end
    end
  end
  # namespace creates routes prefixed with /admin/
  # admin_root_path → /admin/
  # admin_users_path → /admin/users

  resources :contacts do
    collection do
      get :export
      get :export_selected
      get :import
      post :import_create
      delete :bulk_destroy
    end
  end

  resource :account, only: [:show, :edit, :update, :destroy] do
    get :edit_email, on: :member
    patch :update_email, on: :member
    get :edit_password, on: :member
    patch :update_password, on: :member
    get :danger, on: :member
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
end
