require 'test_helper'

class GooglecontactsControllerTest < ActionController::TestCase
  setup do
    @googlecontact = googlecontacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:googlecontacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create googlecontact" do
    assert_difference('Googlecontact.count') do
      post :create, :googlecontact => @googlecontact.attributes
    end

    assert_redirected_to googlecontact_path(assigns(:googlecontact))
  end

  test "should show googlecontact" do
    get :show, :id => @googlecontact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @googlecontact.to_param
    assert_response :success
  end

  test "should update googlecontact" do
    put :update, :id => @googlecontact.to_param, :googlecontact => @googlecontact.attributes
    assert_redirected_to googlecontact_path(assigns(:googlecontact))
  end

  test "should destroy googlecontact" do
    assert_difference('Googlecontact.count', -1) do
      delete :destroy, :id => @googlecontact.to_param
    end

    assert_redirected_to googlecontacts_path
  end
end
