class HomesController < ApplicationController
  def top
  	# コメント数の多い上3つを取得
  	rank_book = Book.find(Comment.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))

	@ranking = []
	@book_id = []
  	rank_book.each do |rank|
  		@ranking.push(get_json_from_selflink(rank.selflink))
  		@book_id.push(rank.id)
  	end
  end

  def about
  end
end
