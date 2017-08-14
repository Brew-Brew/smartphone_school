require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quiz_index_url
    assert_response :success
  end

  test "should get score" do
    get quiz_score_url
    assert_response :success
  end

  test "should get solve" do
    get quiz_solve_url
    assert_response :success
  end

  test "should get text" do
    get quiz_text_url
    assert_response :success
  end

end
