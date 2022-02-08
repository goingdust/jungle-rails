require 'rails_helper'

RSpec.feature 'Visitor navigates to the product detail page', type: :feature, js: true do
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

  scenario 'They see all product details' do
    visit root_path

    find('img', match: :first).click
    sleep 5
    save_screenshot

    expect(page).to have_css 'article.product-detail'
  end
end
