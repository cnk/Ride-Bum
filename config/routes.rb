RideBum::Application.routes.draw do
  resources :events do
    resources :invitations do
      get :send_emails, on: :collection
    end
  end

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
  root to: "pages#index"

end
