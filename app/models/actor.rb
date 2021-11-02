class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def coactors #this is ruby and that is bad
    coactors = []
    movies.each do |movie|
      movie.actors.each do |actor|
        coactors << actor
      end
    end
    coactors.delete(self)
    coactors.uniq
  end
end