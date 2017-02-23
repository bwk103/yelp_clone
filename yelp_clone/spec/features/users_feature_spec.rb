require 'rails_helper'

feature "User can sign in and out" do
  # before do
  #   create_restaurant
  # end

  context "User not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit ('/')
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it "should not see the 'sign out' link" do
      visit('/')
      expect(page).not_to have_link 'Sign out'
    end

    it "should not allow users to add new restaurants" do
      visit('/')
      click_link "Add a restaurant"
      expect(page).to have_content("Log in")
      expect(page).not_to have_content("Create Restaurant")
    end

    it "should not allow users to delete restuarants" do
      sign_up
      create_restaurant
      click_link 'Sign out'
      click_link 'Delete Bills'
      expect(page).to have_content("Log in")
      expect(page).not_to have_content("Deleted successfully")
    end
  end
  context "User signed in on the homepage" do
    before do
      visit('/')
      click_link 'Sign up'
      fill_in('Email', with: 'bob@test.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button 'Sign up'
    end

    it "should see a 'sign out' link" do
      expect(page).to have_content('Sign out')
    end

    it "should not see a 'sign in' or 'sign up' link" do
      expect(page).not_to have_content('Sign in')
      expect(page).not_to have_content('Sign up')
    end
  end

  context "User limitations" do
    before do
      sign_up
      create_restaurant
      rogue_sign_up
    end

    it "allows only the author to edit the restaurant details" do
      click_link "Edit Bills"
      expect(page).to have_content("You do not have permission to edit this restaurant")
    end

    it "allows only the author to delete the restaurant details" do
      click_link "Delete Bills"
      expect(page).to have_content("You do not have permission to delete this restaurant")
    end
  end
end
