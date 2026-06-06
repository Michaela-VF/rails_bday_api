Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do # CRUD (index, show, create, update, destroy)
    member do # domain-specific queries/actions
      get :birthday
      get :age
      get :next_birthday
    end
  end
end
