class Reading < ApplicationRecord
	belongs_to :user
	belongs_to :book

	validates :user_id, presence: true
	validates :book_id, presence: true
    validates :reading_status, presence: true
    validates :readed_status, inclusion: {in: [true, false]}
end
