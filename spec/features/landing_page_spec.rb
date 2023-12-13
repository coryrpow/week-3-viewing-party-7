require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "test", password_confirmation: "test")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password", password_confirmation: "password")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    # user1 = User.create(name: "User One", email: "user1@test.com")
    # user2 = User.create(name: "User Two", email: "user2@test.com")
    visit login_path

    fill_in :email, with: @user2.email
    fill_in :password, with: @user2.password
    click_on 'Log In'

    visit root_path
    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end     
  end 
   
  it "as a logged in user, when I visit a landing page I no longer see a link to Log In
  or Create an Account but a link to Log Out. When clicked I am taken to the landing page and the Log Out
  has changed back to a Log In link" do
   visit login_path

   fill_in :email, with: @user2.email
   fill_in :password, with: @user2.password
   click_on 'Log In'

   expect(current_path).to eq(user_path(@user2.id))
   visit '/'

   expect(page).to have_link("Log Out")
   click_link("Log Out")

   expect(current_path).to eq(root_path)
   expect(page).to have_link("Log In")
  end

  it "as a visitor when I visit the landing page I do not see the section
    of the page that lists existing users" do
      visit root_path

      expect(page).to_not have_content("Existing Users:")
  end

  it "as a REGISTERED user when I visit the landing page the list of existing users is just a list
  of email addresses" do
    visit login_path

    fill_in :email, with: @user2.email
    fill_in :password, with: @user2.password
    click_on 'Log In'

    expect(current_path).to eq(user_path(@user2.id))
    visit root_path

    within('.existing-users') do 
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end  

  end

    it "as a visitor if I try to visit the '/dashboard' I remain on the landing page
    and see a message telling me I must be logged in. " do
      # visit login_path

      # fill_in :email, with: @user2.email
      # fill_in :password, with: @user2.password
      # click_on 'Log In'
      visit user_path(@user2.id)

      expect(page).to have_content("You gotta log in, bruh. Can't see your dashboard without logging in.")
      expect(current_path).to eq(root_path)
    end
end