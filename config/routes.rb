Rails.application.routes.draw do
  # get "/", :controller: "movies", :action: "index"
  root "movies#index" #super shorthand way of writing controller and action for root route

  # Routes for the Movie resource:

  # CREATE
  post "/movies" => "movies#create", as: :movies #movies_url and movies_path
  get "/movies/new" => "movies#new", as: :new_movie #new_movie_url and new_movie_path
          
  # READ
  get "/movies" => "movies#index"
  get "/movies/:id" => "movies#show", as: :movie #to create a method called movie_path() (expects an argument to populate :id segment)
  
  # UPDATE
  patch "/movies/:id" => "movies#update"
  get "/movies/:id/edit" => "movies#edit", as: :edit_movie #edit_movie_path
  
  # DELETE
  delete "/movies/:id" => "movies#destroy"

  resources :directors
  #------------------------------
end