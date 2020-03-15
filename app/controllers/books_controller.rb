class BooksController < ApplicationController
	def show
		if params[:search].blank?
			# 空白なら画面は元の画面のまま
			redirect_back(fallback_location: root_path)
		else
			@response = get_json_from_isbn(params[:search])
			@search = params[:search]

			# google book apiからjsonファイルを取得できているのでbookテーブルに登録
			# まだ登録されていないisbnなら登録
			isbn = get_isbn_13(@response)
			@book = create(isbn)	# createを実施

			# isbnで検索した結果が空の場合.newで宣言
			if @response["totalItems"] == 0
				@reading = Reading.new
			else
				# ユーザーの読書履歴にあるか確認
				if Reading.find_by(user_id: current_user.id, book_id: @book.id).nil?
					@reading = Reading.new
				else
					@reading = Reading.find_by(user_id: current_user.id, book_id: @book.id)
				end
			end
		end
	end

	def search
		if params[:search].blank?
			# 空白なら画面は元の画面のまま
			redirect_back(fallback_location: root_path)
		else
			# ApplicationController内のメソッドを使用
			# クラス変数によりshowに渡す
			@@response = get_json_from_isbn(params[:search])
			@@search = params[:search]


			# google book apiからjsonファイルを取得できているのでbookテーブルに登録
			# まだ登録されていないisbnなら登録
			isbn = get_isbn_13(@@response)
			if Book.find_by(isbn: isbn)
				@@book = Book.find_by(isbn: isbn)
			else
				@@book = Book.new(isbn: isbn)
				@@book.save
			end

			redirect_to books_path
		end
	end



	private

	def create(isbn)
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
