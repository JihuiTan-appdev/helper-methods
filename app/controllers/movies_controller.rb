class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    #.html.erb is the assumed extension
    #render template: "movies/new"
    # if controller and action names match, could omit
  end

  def index
    @movies = Movie.all.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html #do
        #render template: "movies/index"
    end
  end

  def show
    #@movie = Movie.where( id: params.fetch(:id) ).first
    #@movie = Movie.find_by(id: params.fetch(:id) )
    @movie = Movie.find(params.fetch(:id))
    #render template: "movies/show"
  end

  def create
    movie_attrs = params.require(:movie).permit(:title,:description)

    @movie = Movie.new(movie_attrs)

    if @movie.valid?
      @movie.save
      redirect_to  movies_url, notice: "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))

    #render template: "movies/edit"
  end

  def update
    movie = Movie.find(params.fetch(:id))
    movie_attrs = params.require(:movie).permit(:title,:description)
    movie = Movie.new(movie_attrs)

    if movie.valid?
      movie.save
      redirect_to  movie_url(movie),  notice: "Movie updated successfully." 
    else
      redirect_to  movie_url(movie),  alert:  "Movie failed to update successfully." 
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))
    movie.destroy

    redirect_to  movies_url,  notice: "Movie deleted successfully."
  end
end
