require 'test_helper'

class RunnersControllerTest < ActionController::TestCase
  setup do
    @runner = runners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create runner" do
    assert_difference('Runner.count') do
      post :create, runner: { age_group: @runner.age_group, country: @runner.country, gun_pace: @runner.gun_pace, gun_time: @runner.gun_time, name: @runner.name, net_pace: @runner.net_pace, net_time: @runner.net_time, place: @runner.place, place_in_age_group: @runner.place_in_age_group, place_in_sex: @runner.place_in_sex, sex: @runner.sex, state: @runner.state }
    end

    assert_redirected_to runner_path(assigns(:runner))
  end

  test "should show runner" do
    get :show, id: @runner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @runner
    assert_response :success
  end

  test "should update runner" do
    patch :update, id: @runner, runner: { age_group: @runner.age_group, country: @runner.country, gun_pace: @runner.gun_pace, gun_time: @runner.gun_time, name: @runner.name, net_pace: @runner.net_pace, net_time: @runner.net_time, place: @runner.place, place_in_age_group: @runner.place_in_age_group, place_in_sex: @runner.place_in_sex, sex: @runner.sex, state: @runner.state }
    assert_redirected_to runner_path(assigns(:runner))
  end

  test "should destroy runner" do
    assert_difference('Runner.count', -1) do
      delete :destroy, id: @runner
    end

    assert_redirected_to runners_path
  end
end
