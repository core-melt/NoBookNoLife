class Book < ApplicationRecord
	validates :isbn, presence: true

	has_many :readings, dependent: :destroy
	has_many :comments, dependent: :destroy

	# commentsテーブル経由でchild_commentsを取得できるようにする
	has_many :child_comments, through: :comments, foreign_key: "comment_id", dependent: :destroy

	# コメントが子コメントであるか確認
	def child_comment?(comment)
		self.child_comments.find_by(comment_id: comment.id)
	end
end
