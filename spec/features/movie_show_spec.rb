require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "test", password_confirmation: "test")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end 
  end 

  it 'shows all movies' do 
    visit '/login'

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_on 'Log In'

    click_button "Find Top Rated Movies"

    expect(current_path).to eq(movies_path)

    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end

  it "if i got to a movies show page and click create a viewing party I'm redirected
  to the movies show page and a message appears to let me know I must be logged in " do
    movie_1 = Movie.first

    visit movie_path(movie_1.id)

    click_button("Create a Viewing Party")
    
    expect(page).to have_content("You gotta log in, bruh. Can't create a viewing party without logging in.")
    expect(current_path).to eq(movie(movie_1.id))

  end
end