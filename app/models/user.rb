class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  scope :ci_find, ->(attribute, value) { where("lower(#{attribute}) = ?", value.downcase) }

  def authenticate_with_credentials(email, password)
    user = User.ci_find('email', email.strip)
    if user.empty?
      nil
    else
      user.first.authenticate(password) || nil
    end
  end
end
