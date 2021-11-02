require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it { should belong_to(:studio) }
    it { should have_many :movie_actors }
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe '#ordered_actors' do
    it 'orders the actors from youngest to oldest' do
      studio1 = Studio.create!(name: 'MGM', location: 'California')
      movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
      kevin = Actor.create!(name: 'Kevin', age: 24)
      micha = Actor.create!(name: 'Micha', age: 27)
      amwake = Actor.create!(name: 'Amwake', age: 33)
      MovieActor.create!(movie_id: movie1.id, actor_id: kevin.id)
      MovieActor.create!(movie_id: movie1.id, actor_id: micha.id)
      MovieActor.create!(movie_id: movie1.id, actor_id: amwake.id)

      expect(movie1.ordered_actors).to eq([kevin, micha, amwake])
    end
  end
end
