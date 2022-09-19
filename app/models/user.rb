class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :orders, dependent: :destroy
  enum role: {admin: 0, customer: 1}

  USER_ATTRS = %w(name email password password_confirmation phone_num
                 address).freeze
  before_save :downcase_email

  validates :name,  presence: true,
                    length: {maximum: Settings.user.name.name_max_length}
  validates :phone_num, allow_nil: true,
                        length: {is: Settings.user.phone.phone_length},
                        numericality: {only_integer: true},
                        uniqueness: {case_sensitive: false}
  validates :address, allow_nil: true,
                      length: {in: Settings.user.address.address_range_length}
  validates :email, presence: true,
                    length: {in: Settings.user.email.email_range_length},
                    format: {with: Settings.user.email_regex},
                    uniqueness: {case_sensitive: false}
  validates :password,  presence: true,
                        length: {minimum: Settings.user.password.password_min},
                        allow_nil: true, if: :password

  scope :name_asc, ->{order name: :asc}

  class << self
    def from_omniauth auth
      where(provider: auth.uid, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.uid = auth.uid
        user.provider = auth.provider
        user.skip_confirmation!
      end
    end
  end

  private
  def downcase_email
    email.downcase!
  end
end
