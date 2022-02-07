require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    before do
      @user1 = User.new(first_name: 'Tanjiro', last_name: 'Kamado', email: 'waterwheel@mail.com', password: 'nezuko',
                        password_confirmation: 'nezuko')
    end

    it 'should be saved successfully with all required fields set' do
      @user1.save
      expect(@user1.errors.full_messages).to be_empty
    end

    context 'first name' do
      it 'should include an error if empty' do
        @user2 = User.new(last_name: 'Hashibira', email: 'fightme@mail.com',
                          password: 'tanjiro', password_confirmation: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include("First name can't be blank")
      end
    end

    context 'last name' do
      it 'should include an error if empty' do
        @user2 = User.new(first_name: 'Inosuke', email: 'fightme@mail.com',
                          password: 'tanjiro', password_confirmation: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end
end
