require 'rails_helper'

RSpec.feature 'Visitor logs in', type: :feature, js: true do
  before :each do
    User.create! first_name: 'Tanjiro', last_name: 'Kamado', email: 'waterwheel@mail.com', password: 'nezuko',
                 password_confirmation: 'nezuko'
  end

  scenario 'They see their first name and logout in nav bar' do
    visit '/login'
    fill_in 'email', with: 'waterwheel@mail.com'
    fill_in 'password', with: 'nezoku'
    click_on 'Submit'
    sleep 5
    save_screenshot
    expect(page.find('nav.navbar-fixed-top')).to have_text "#{@user.first_name} | Logout"
  end
end
