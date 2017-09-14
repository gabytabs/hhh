require 'test_helper'

class MangaTitlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manga_titles_index_url
    assert_response :success
  end

  test "should get show" do
    get manga_titles_show_url
    assert_response :success
  end

  test "should get create" do
    get manga_titles_create_url
    assert_response :success
  end

end
