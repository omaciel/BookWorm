Bookworm::Application.routes.draw do
    resources :users
    resources :books
    resources :sessions, :only => [:new, :create, :destroy]

    match '/signup', :to => 'users#new'
    match '/signin',  :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'

    match '/contact', :to => "pages#contact"
    match '/about', :to => "pages#about"

    root :to => 'pages#home'

end
