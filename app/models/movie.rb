class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def ordered_actors
    actors.order(:age)
  end

  def average_age
    actors.average(:age)
  end
end
