class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.ordered_actors
    if params[:name]
      new_actor = Actor.find_by name: params[:name], age: params[:age]
      MovieActor.create!(movie_id: @movie.id, actor_id: new_actor.id)
    end
  end
end