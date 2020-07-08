Rails.application.routes.draw do
  root "books#index"
  resources :books
  resources :authors

  # show book's authors route
  get '/book/:id/authors' , to: "authors#index" , as: "book_authors"
  # show author's books route
  get '/author/:id/books' , to: "books#index" , as: "author_books"
  # resources :author_apis
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/author_apis/authors', to: "author_api#index"
  get '/author_apis/authors/:id/books', to: "author_api#show" 

end
