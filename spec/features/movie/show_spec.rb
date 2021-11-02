require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  it 'shows the movies title, creation year, and genre' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")

    visit "/movies/#{movie1.id}"

    expect(page).to have_content("movie1")
    expect(page).to have_content("1994")
    expect(page).to have_content("Horror")
  end

  it 'shows all of a movies actors from youngest to oldest' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
    kevin = Actor.create!(name: 'Kevin', age: 24)
    micha = Actor.create!(name: 'Micha', age: 27)
    amwake = Actor.create!(name: 'Amwake', age: 33)
    MovieActor.create!(movie_id: movie1.id, actor_id: kevin.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: micha.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: amwake.id)

    visit "/movies/#{movie1.id}"

    expect(kevin.name).to appear_before(micha.name)
    expect(micha.name).to appear_before(amwake.name)
  end

  it 'shows the average age of all actors' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
    kevin = Actor.create!(name: 'Kevin', age: 24)
    micha = Actor.create!(name: 'Micha', age: 27)
    amwake = Actor.create!(name: 'Amwake', age: 33)
    MovieActor.create!(movie_id: movie1.id, actor_id: kevin.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: micha.id)
    MovieActor.create!(movie_id: movie1.id, actor_id: amwake.id)

    visit "/movies/#{movie1.id}"

    expect(page).to have_content('The average age of actors is: 28.0')
  end
end