class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  enum role: {admin: 0, user: 1}
end
