require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(id: 1, name: 'Electronics')
      @category.save
    end

    it 'should be saved successfully with all required fields set' do
      @product = Product.new(name: 'Smartwatch', price_cents: 100_000, quantity: 5, category_id: 1)
      @product.save
      expect(@product.id).to be_present
    end

    context 'name' do
      it 'should include an error if empty' do
        @product = Product.new(price_cents: 100_000, quantity: 5, category_id: 1)
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'price' do
      it 'should include an error if empty' do
        @product = Product.new(name: 'Smartwatch', quantity: 5, category_id: 1)
        @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it 'should include an error if not a number' do
        @product = Product.new(name: 'Smartwatch', price_cents: 'one hundred thousand', quantity: 5, category_id: 1)
        @product.save
        expect(@product.errors.full_messages).to include('Price cents is not a number')
      end
    end

    context 'quantity' do
      it 'should include an error if empty' do
        @product = Product.new(name: 'Smartwatch', price_cents: 100_000, category_id: 1)
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'category' do
      it 'should include an error if empty' do
        @product = Product.new(name: 'Smartwatch', price_cents: 100_000, quantity: 5)
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
