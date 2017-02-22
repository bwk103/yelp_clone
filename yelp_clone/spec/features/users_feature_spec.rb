require 'rails_helper'

feature "User can sign in and out" do
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
end
