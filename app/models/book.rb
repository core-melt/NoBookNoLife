class Book < ApplicationRecord
	has_many :readings, dependent: :destroy
	has_many :comments, dependent: :destroy

	validates :isbn, presence: true
end
