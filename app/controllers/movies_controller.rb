class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    render "new"
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html do
        render "index"
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
    movie_attributes = params.require(:movie).permit(:title, :description) #whitelist title and description columns. Replace fetch.
    @movie = Movie.new(movie_attributes) # this code replace the two lines of code below it because we have .new method receiving a Hash
    # @movie.title = params.fetch(:movie).fetch(:title)
    # @movie.description = params.fetch(:movie).fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
    # render template: "movies/edit" can drop this because name is matched the action
  end

  def update
    movie = Movie.find(params.fetch(:id))
    movie_attributes = params.require(:movie).permit(:title, :description)
    movie.update(movie_attributes)

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
