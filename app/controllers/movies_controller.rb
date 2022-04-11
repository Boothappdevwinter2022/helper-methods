class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    render template: "movies/new"
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html do
        render template: "movies/index"
      end
    end
  end

  def show
    # @the_movie = Movie.where(id: params.fetch(:id)).first
    # @the_movie = Movie.find_by(id: params.fetch(:id)) # this is the same as the line above
    @movie = Movie.find(params.fetch(:id)) # this is the same as the line above
    
    render template: "movies/show" # technically can remove this row since template name is the same as action
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("title")
    @movie.description = params.fetch("description")

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
    # render template: "movies/edit" can drop this because name is matched the action
  end

  def update
    movie = Movie.find(params.fetch(:id))

    movie.title = params.fetch("title")
    movie.description = params.fetch("description")

    if movie.valid?
      movie.save
      redirect_to movie_url(movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))

    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
