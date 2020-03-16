class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :book
	has_many :child_comments

	validates :user_id, presence: true
	validates :book_id, presence: true
	validates :comment, presence: true
end
