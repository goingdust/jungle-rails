require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do
      @category = Category.new(id: 1, name: 'Electronics')
      @category.save
      @product = Product.new(name: 'Smartwatch', price_cents: 100_000, quantity: 5, category_id: 1)
    end

    it 'should be saved successfully with all required fields set' do
      @product.save
  
      expect(@product.id).to be_present
    end

    context 'name' do
      it 'should return an error if empty' do
        @product = Product.new(price_cents: 100_000, quantity: 5, category_id: 1)
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'price' do
      it 'should return an error if empty'
    end
  end
end
