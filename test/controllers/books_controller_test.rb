require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new," do
    get books_new,_url
    assert_response :success
  end

  test "should get index," do
    get books_index,_url
    assert_response :success
  end

  test "should get show" do
    get books_show_url
    assert_response :success
  end
end
