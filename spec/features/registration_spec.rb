require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with:'test'
    fill_in :user_password_confirmation, with:'test'
    click_button 'Create New User'
    # require 'pry';binding.pry

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("user one's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "test", password_confirmation: "test")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with:'test'
    fill_in :user_password_confirmation, with:'test'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "does not create a user if the passwords don't match" do
    # User.create(name: 'User One', email: 'otunique@example.com', password: "password", password_confirmation: "antipassword")
    visit register_path

    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with: 'user2@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'antipassword'

    click_on "Create New User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
