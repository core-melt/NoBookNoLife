class ChildComment < ApplicationRecord
	belongs_to :comment
	validates :comment_id, presence: true
end
