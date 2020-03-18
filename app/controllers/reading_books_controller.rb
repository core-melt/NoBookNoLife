class ReadingBooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @readings = @user.readings
  end

  def create
  	@reading = current_user.readings.new(book_id: params[:book_id], reading_status: params[:reading_status].to_i)

  	if params[:reading_status] == "4"
  		# 読了の場合
  		@reading[:readed_status] = true
  	else
  		# 未読了の場合
  		@reading[:readed_status] = false
  	end

	  @reading.save

    # 非同期でのリダイレクト用
    @book = Book.find_by(id: params[:book_id])
  end

  def update
  	@reading = Reading.find_by(id: params[:id])

    # 元々読了ならば未読に戻さない
    readed = false
  	if params[:reading_status] == "4" || @reading[:readed_status]
  		# 読了の場合
  		readed = true
  	end
	  @reading.update(reading_status: params[:reading_status].to_i, readed_status: readed)

    # 非同期でのリダイレクト用
    @book = Book.find_by(id: params[:book_id])
  end

  def destroy
  	if @reading[:readed_status]
  		# 読了の場合は削除しない
  		# 元の画面のまま

  		redirect_back(fallback_location: root_path)
  	else
  		# 未読了の場合
  		@reading = Reading.find_by(id: params[:id])
  		@reading.destroy

      # 非同期でのリダイレクト用
      @reading = Reading.new
      @book = Book.find_by(id: params[:book_id])
  	end
  end
end
