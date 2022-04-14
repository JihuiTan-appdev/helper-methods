class DirectorsController < ApplicationController
  def new
    @director = Director.new

  end

  def index
    @directors = Director.all.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show

    @director = Director.find(params.fetch(:id))
    
  end

  def create
    director_attrs = params.require(:director).permit(:name,:age)

    @director = Director.new(director_attrs)

    if @director.valid?
      @director.save
      redirect_to  directors_url, notice: "director created successfully."
    else
      render template: "directors/new"
    end
  end

  def edit
    @director = Director.find(params.fetch(:id))

    #render template: "movies/edit"
  end

  def update
    director = Director.find(params.fetch(:id))
    director_attrs = params.require(:director).permit(:name,:age)
    director = Director.new(director_attrs)

    if director.valid?
      director.save
      redirect_to  director_url(director),  notice: "director updated successfully." 
    else
      redirect_to  director_url(director),  alert:  "director failed to update successfully." 
    end
  end

  def destroy
    director = Director.find(params.fetch(:id))
    director.destroy

    redirect_to  directors_url,  notice: "director deleted successfully."
  end
end
