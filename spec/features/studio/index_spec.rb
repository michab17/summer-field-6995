require 'rails_helper'

RSpec.describe 'Studio Index page' do
  it 'shows each studios name and location' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    studio2 = Studio.create!(name: 'Pixar', location: 'Florida')

    visit '/studios'

    expect(page).to have_content('MGM')
    expect(page).to have_content('California')
    expect(page).to have_content('Pixar')
    expect(page).to have_content('Florida')
  end

  it 'lists all of a studios movies under the studio' do
    studio1 = Studio.create!(name: 'MGM', location: 'California')
    studio2 = Studio.create!(name: 'Pixar', location: 'Florida')
    movie1 = studio1.movies.create!(title: 'movie1', creation_year: 1994, genre: "Horror")
    movie2 = studio1.movies.create!(title: 'movie2', creation_year: 1994, genre: "Horror")
    movie3 = studio2.movies.create!(title: 'movie3', creation_year: 1994, genre: "Horror")
    movie4 = studio2.movies.create!(title: 'movie4', creation_year: 1994, genre: "Horror")

    visit "/studios"
 
    within "#id-#{studio1.id}" do
      expect(page).to have_content(movie1.title)
      expect(page).to have_content(movie2.title)
    end

    within "#id-#{studio2.id}" do
      expect(page).to have_content(movie3.title)
      expect(page).to have_content(movie4.title)
    end
  end
end