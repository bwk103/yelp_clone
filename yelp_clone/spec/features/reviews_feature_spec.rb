require 'rails_helper'

feature 'reviewing' do
  before do
    sign_up
    create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Bills'
    fill_in 'Thoughts', with: 'Bang average!'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    save_and_open_page
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Bang average!')
  end
end
