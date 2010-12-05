require 'test_helper'

class ExpenseLinesControllerTest < ActionController::TestCase
  setup do
    @expense_line = expense_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_line" do
    assert_difference('ExpenseLine.count') do
      post :create, :expense_line => @expense_line.attributes
    end

    assert_redirected_to expense_line_path(assigns(:expense_line))
  end

  test "should show expense_line" do
    get :show, :id => @expense_line.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @expense_line.to_param
    assert_response :success
  end

  test "should update expense_line" do
    put :update, :id => @expense_line.to_param, :expense_line => @expense_line.attributes
    assert_redirected_to expense_line_path(assigns(:expense_line))
  end

  test "should destroy expense_line" do
    assert_difference('ExpenseLine.count', -1) do
      delete :destroy, :id => @expense_line.to_param
    end

    assert_redirected_to expense_lines_path
  end
end
