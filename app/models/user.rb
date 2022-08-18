class User < ApplicationRecord
  has_many :orders, dependent: :destroy
end
