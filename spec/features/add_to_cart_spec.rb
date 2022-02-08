require 'rails_helper'

RSpec.feature 'Visitor adds product to cart', type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'The My Cart button changes from 0 to 1' do
    visit root_path

    find('form.button_to', match: :first).click
    sleep 5
    save_screenshot

    expect(page.find('nav.navbar-fixed-top')).to have_text 'My Cart (1)'
  end
end
