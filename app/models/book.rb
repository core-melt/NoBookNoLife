class Book < ApplicationRecord
	validates :isbn, presence: true

	has_many :readings, dependent: :destroy
	has_many :comments, dependent: :destroy
end
