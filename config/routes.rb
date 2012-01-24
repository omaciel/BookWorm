Bookworm::Application.routes.draw do
    resources :users

    match '/signup', :to => 'users#new'

    match '/contact', :to => "pages#contact"
    match '/about', :to => "pages#about"

    root :to => 'pages#home'

    #resources :books

end
