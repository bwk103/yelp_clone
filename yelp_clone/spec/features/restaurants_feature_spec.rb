require 'rails_helper'

feature 'restatuants' do
  before do
    sign_up
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      @user = User.create(email:'test@test.com', password: 'testtest', password_confirmation: 'testtest')
      Restaurant.create(name: 'Nandos', description: 'Chicken shop', user_id: @user.id)
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Nandos')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context "creating restaurants" do
    scenario "prompts user to fill out a new form and then displays the restaurant" do
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: "Dirty chicken"
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end
  end

  context "viewing restaurants" do
    scenario "lets a user view a restaurant" do
      create_restaurant
      bills = Restaurant.first
      click_link 'Bills'
      expect(page).to have_content('Bills')
      expect(current_path).to eq "/restaurants/#{bills.id}"
    end
  end

  context "editing restaurants" do

    before do
      create_restaurant
    end

    scenario "let a user edit a restaurant" do
      visit '/restaurants'
      click_link 'Edit Bills'
      fill_in 'Name', with: 'Bills Restaurant'
      fill_in 'Description', with: 'Cheap and cheerful'
      click_button 'Update Restaurant'
      click_link 'Bills Restaurant'
      expect(page).to have_content('Bills Restaurant')
      expect(page).to have_content('Cheap and cheerful')
    end
  end

  context "deleting restaurants" do
    before do
      create_restaurant
    end

    scenario "removes a restaurant when the user clicks a delete link" do
      visit '/restaurants'
      click_link 'Delete Bills'
      expect(page).not_to have_content('Bills')
      expect(page).to have_content('Restaurant deleted successfully')
    end
  end

  context 'an invalid restaurant' do
    scenario 'does not allow you to submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
end
