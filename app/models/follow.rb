class Follow < ApplicationRecord
	belongs_to :user

	validates :user_id, presence: true
	validates :follow_id, presence: true
end
