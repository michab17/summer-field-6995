require 'rails_helper'

RSpec.describe 'Actors Show page' do
  it 'displays the actors name and age' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
    kevin = Actor.create!(name: 'Kevin', age: 24)
    MovieActor.create!(movie_id: movie1.id, actor_id: kevin.id)

    visit "/actors/#{kevin.id}"

    expect(page).to have_content('Kevin')
    expect(page).to have_content('24')
  end

  it 'displays a unique list of all actors the actor has worked with' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
    kevin = Actor.create!(name: 'Kevin', age: 24)
    micha = Actor.create!(name: 'Micha', age: 27)
    amwake = Actor.create!(name: 'Amwake', age: 33)
    MovieActor.create!(movie_id: movie1.id, actor_id: kevin.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: micha.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: amwake.id)

    visit "/actors/#{kevin.id}"

    expect(page).to have_content("Actors #{kevin.name} has worked with:")
    expect(page).to have_content("Micha")
    expect(page).to have_content("Amwake")
  end
end