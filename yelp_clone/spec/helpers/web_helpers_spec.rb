require 'rails_helper'

def sign_up
  visit('/')
  click_link 'Sign up'
  fill_in('Email', with: 'bob@test.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button "Sign up"
end

def create_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'Bills'
  fill_in 'Description', with: "A bit of everything"
  click_button 'Create Restaurant'
end

def rogue_sign_up
  click_link 'Sign out'
  visit('/')
  click_link 'Sign up'
  fill_in('Email', with: 'rogue@test.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button "Sign up"
end
