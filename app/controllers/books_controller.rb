class BooksController < ApplicationController
	def show
		@response = get_json_from_selflink(params[:search])
		@search = params[:search]

		# isbnで検索した結果が空の場合.newで宣言
		if @response["totalItems"] == 0
			@reading = Reading.new
		else
			# google book apiからjsonファイルを取得できているのでbookテーブルに登録
			# まだ登録されていないisbnなら登録
			@book = create	# createを実施

			if user_signed_in?
				# 読書履歴情報取得
				# ユーザーの読書履歴にあるか確認
				if Reading.find_by(user_id: current_user.id, book_id: @book.id).nil?
					@reading = Reading.new
				else
					@reading = Reading.find_by(user_id: current_user.id, book_id: @book.id)
				end
			end

			# コメント情報取得
			comments = @book.comments.order(created_at: "DESC")
			@comments = comments.page(params[:page])
		end
	end

	def index
	 	if params[:search].blank?
	 		# 空白なら画面は元の画面のまま
	 		redirect_back(fallback_location: root_path)
	 	else
			@response = get_json_from_q(params[:search])
			#@response = @response.page(params[:page])
			@search = params[:search]
	 	end
	end

	private

	# 検索に成功した書籍情報の登録
	# Bookに未登録ならSAVE。登録済みなら登録情報を返す
	def create
		if Book.find_by(selflink: @response["selfLink"])
			book = Book.find_by(selflink: @response["selfLink"])
		else
			book = Book.new(selflink: @response["selfLink"])
			book.save
		end

		return book
	end
end
