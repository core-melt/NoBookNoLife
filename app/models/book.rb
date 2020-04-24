class Book < ApplicationRecord
	validates :selflink, presence: true

	has_many :readings, dependent: :destroy
	has_many :comments, dependent: :destroy
end
