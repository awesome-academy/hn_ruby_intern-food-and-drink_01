class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name,  presence: true,
                    length: {maximum: Settings.category.name.name_max_length},
                    uniqueness: {case_sensitive: false}

  scope :asc_name, ->{order name: :asc}
end
