class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :book
	has_many :child_comments
	has_many :nices

	validates :user_id, presence: true
	validates :book_id, presence: true
	validates :comment, presence: true


	def niced_by?(user)
    	self.nices.where(user_id: user.id).exists?
  	end
end
