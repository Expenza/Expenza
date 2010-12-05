require 'test_helper'

class ExpenseReportsControllerTest < ActionController::TestCase
  setup do
    @expense_report = expense_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_report" do
    assert_difference('ExpenseReport.count') do
      post :create, :expense_report => @expense_report.attributes
    end

    assert_redirected_to expense_report_path(assigns(:expense_report))
  end

  test "should show expense_report" do
    get :show, :id => @expense_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @expense_report.to_param
    assert_response :success
  end

  test "should update expense_report" do
    put :update, :id => @expense_report.to_param, :expense_report => @expense_report.attributes
    assert_redirected_to expense_report_path(assigns(:expense_report))
  end

  test "should destroy expense_report" do
    assert_difference('ExpenseReport.count', -1) do
      delete :destroy, :id => @expense_report.to_param
    end

    assert_redirected_to expense_reports_path
  end
end
