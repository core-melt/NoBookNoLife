class BookNicesController < ApplicationController
  # BooksNicesだがbookのコメントに対していいねを行う
  before_action :authenticate_user!
  def create
  	@cmt = Comment.find_by(id: params[:comment_id])
  	nice = current_user.nices.new(comment_id: @cmt.id)
  	nice.save
  end

  def destroy
  	@cmt = Comment.find_by(id: params[:comment_id])
  	nice = current_user.nices.find_by(comment_id: @cmt.id)
  	nice.destroy
  end
end
