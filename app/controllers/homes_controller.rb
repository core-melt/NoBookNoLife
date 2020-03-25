class HomesController < ApplicationController
  def top
  	rank_book = Book.find(Comment.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))

	@ranking = []
  	rank_book.each do |rank|
  		@ranking.push(get_json_from_isbn(rank.isbn))
  	end
  end

  def about
  end
end
