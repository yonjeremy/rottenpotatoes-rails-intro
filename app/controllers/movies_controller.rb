class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = Movie.getRatings
    
    
    session[:ssort_param] = params[:sort_param] if params[:sort_param]
    session[:sratings] = params[:ratings] if params[:ratings]
    
    if session[:sratings]
      @selected = session[:sratings].keys
      @movies = Movie.where(rating: @selected).order("#{session[:ssort_param]} ")
      
    else
      @movies = Movie.order("#{session[:ssort_param]} ")
    end
    
    @className = 'hilite' && session[:ssort_param]


    # render :text => params[:ratings].keys.inspect

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
