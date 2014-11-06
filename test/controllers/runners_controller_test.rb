require 'test_helper'

class RunnersControllerTest < ActionController::TestCase
  setup do
    @runner = runners(:one)
  end

  test "should get index" do
    get :index, race_id: @runner.race_id
    assert_response :success
    assert_not_nil assigns(:runners)
  end

  test "should show runner" do
    get :show, race_id: @runner.race_id, id: @runner
    assert_response :success
  end

end
