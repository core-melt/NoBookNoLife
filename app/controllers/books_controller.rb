class BooksController < ApplicationController
	def show
		if params[:search].blank?
			# 空白なら画面は元の画面のまま
			redirect_back(fallback_location: root_path)
		else
			@response = get_json_from_isbn(params[:search])
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
				@comments = @book.comments
			end
		end
	end


	private

	# 検索に成功した書籍情報の登録
	# Bookに未登録ならSAVE。登録済みなら登録情報を返す
	def create
		# 基本ISBN13を登録。存在しない場合のみISBN10を登録
		isbn = get_isbn_13(@response)

		if Book.find_by(isbn: isbn)
			book = Book.find_by(isbn: isbn)
		else
			book = Book.new(isbn: isbn)
			book.save
		end

		return book
	end

	# isbn13を返す。ない場合は10桁を返す
	def get_isbn_13(response)
		if response["items"][0]["volumeInfo"]["industryIdentifiers"][1]["identifier"].blank?
			# ISBN10
			return response["items"][0]["volumeInfo"]["industryIdentifiers"][0]["identifier"]
		else
			# ISBN13
			return response["items"][0]["volumeInfo"]["industryIdentifiers"][1]["identifier"]
		end
	end
end
