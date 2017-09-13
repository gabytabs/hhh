require 'test_helper'

class MangaContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manga_contents_index_url
    assert_response :success
  end

  test "should get show" do
    get manga_contents_show_url
    assert_response :success
  end

end
