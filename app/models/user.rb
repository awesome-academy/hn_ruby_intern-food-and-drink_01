class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  enum role: {admin: 0, customer: 1}

  USER_ATTRS = %w(name email password password_confirmation phone_num
                 address).freeze
  before_save :downcase_email

  validates :name,  presence: true,
                    length: {maximum: Settings.user.name.name_max_length}
  validates :phone_num, presence: true,
                        length: {is: Settings.user.phone.phone_length},
                        uniqueness: {case_sensitive: false}
  validates :address, presence: true,
                      length: {in: Settings.user.address.address_range_length}
  validates :email, presence: true,
                    length: {in: Settings.user.email.email_range_length},
                    format: {with: Settings.user.email_regex},
                    uniqueness: {case_sensitive: false}
  validates :password,  presence: true,
                        length: {minimum: Settings.user.password.password_min},
                        allow_nil: true, if: :password
  has_secure_password
  private

  def downcase_email
    email.downcase!
  end
end
