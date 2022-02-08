require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = User.new(first_name: 'Tanjiro', last_name: 'Kamado', email: 'waterwheel@mail.com', password: 'nezuko',
                      password_confirmation: 'nezuko')
    @user1.save
  end

  describe 'Validations' do
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

    context 'email' do
      it 'should include an error if empty' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', password: 'tanjiro',
                          password_confirmation: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include("Email can't be blank")
      end

      it 'should include an error if email not unique (not case sensitive)' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', email: 'WATERWHEEL@mail.com', password: 'tanjiro',
                          password_confirmation: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    context 'password' do
      it 'should include an error if empty' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', email: 'fightme@mail.com',
                          password_confirmation: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include("Password can't be blank")
      end

      it 'should include an error if not long enough' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', email: 'fightme@mail.com', password: 'tanji',
                          password_confirmation: 'tanji')
        @user2.save
        expect(@user2.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end

    context 'password confirmation' do
      it 'should include an error if empty' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', email: 'fightme@mail.com', password: 'tanjiro')
        @user2.save
        expect(@user2.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'should include an error if confirmation does not match password' do
        @user2 = User.new(first_name: 'Inosuke', last_name: 'Hashibara', email: 'fightme@mail.com',
                          password: 'tanjiro', password_confirmation: 'zenitsu')
        @user2.save
        expect(@user2.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'success' do
      it 'should return a user if credentials correct' do
        expect(@user1.authenticate_with_credentials('waterwheel@mail.com', 'nezuko')).to eq(@user1)
      end

      it 'should return a user if correct email has whitespace before or after' do
        expect(@user1.authenticate_with_credentials('  waterwheel@mail.com ', 'nezuko')).to eq(@user1)
      end
    end

    context 'failure' do
      it 'should return nil if email incorrect' do
        expect(@user1.authenticate_with_credentials('water@mail.com', 'nezuko')).to be_nil
      end

      it 'should return nil if password incorrect' do
        expect(@user1.authenticate_with_credentials('waterwheel@mail.com', 'kizuki')).to be_nil
      end
    end
  end
end
