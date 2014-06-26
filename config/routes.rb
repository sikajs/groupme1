Groupme1::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :groups do
    resources :posts
  end

  root :to => "groups#index"
end
