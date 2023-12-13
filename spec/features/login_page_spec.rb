require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "test", password_confirmation: "test")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password", password_confirmation: "password")
  end 

  it "as a registered user when I visit '/' and I see a link for logging in and click, I'm taken to a login page
  '/login' where I can input my unique email and password. When I enter them I am taken to my dashboard page" do
    visit '/'
    click_link "Log In"

    expect(current_path).to eq('/login')

    fill_in :email, with: @user2.email
    fill_in :password, with: @user2.password
    click_on 'Log In'

    expect(current_path).to eq(user_path(@user2.id))
  end

  it "gives an error message if the login attempt fails" do
    visit '/login'

    fill_in :email, with: @user2.email
    fill_in :password, with: 'antipassword'
    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Bzzt, wrongo, try again.")
  end
end
