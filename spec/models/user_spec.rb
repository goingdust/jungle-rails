# TODO
# It must be created with a password and password_confirmation fields
# - These need to match so you should have an example for where they are not the same
# - These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed
#   if test@test.COM is in the database)
# Email, first name, and last name should also be required

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
  end
end
