class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

    render template: "movies/new"
  end

  def index
    @list_of_movies = Movie.order(created_at: :desc)

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
    @the_movie = Movie.find(params.fetch(:id)) # this is the same as the line above
    
    render template: "movies/show" # technically can remove this row since template name is the same as action
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where(id: the_id)

    @the_movie = matching_movies.first

    # render template: "movies/edit" can drop this because name is matched the action
  end

  def update
    the_movie = Movie.find(params.fetch(:id))

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_movie = Movie.find(params.fetch(:id))

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
