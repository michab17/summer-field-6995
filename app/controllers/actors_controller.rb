class ActorsController < ApplicationController
  def show
    @actor = Actor.find(params[:id])
    @coactors = @actor.coactors
  end
end