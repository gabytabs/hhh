require 'test_helper'

class Api::V1::MangaTitlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_manga_titles_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_manga_titles_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_manga_titles_create_url
    assert_response :success
  end

end
