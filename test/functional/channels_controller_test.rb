require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  setup do
    @channel = channels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:channels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create channel" do
    assert_difference('Channel.count') do
      post :create, :channel => { :color => @channel.color, :gender => @channel.gender, :price => @channel.price, :style => @channel.style }
    end

    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should show channel" do
    get :show, :id => @channel
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @channel
    assert_response :success
  end

  test "should update channel" do
    put :update, :id => @channel, :channel => { :color => @channel.color, :gender => @channel.gender, :price => @channel.price, :style => @channel.style }
    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should destroy channel" do
    assert_difference('Channel.count', -1) do
      delete :destroy, :id => @channel
    end

    assert_redirected_to channels_path
  end
end
