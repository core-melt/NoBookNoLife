require 'test_helper'

class ReadingBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reading_books_index_url
    assert_response :success
  end

end
