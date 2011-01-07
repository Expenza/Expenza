class ExpenseReportsController < ApplicationController
  # GET /expense_reports
  # GET /expense_reports.xml
  before_filter :authenticate_user!
  load_and_authorize_resource #for cancan

  def index
    @expense_reports = ExpenseReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_reports }
    end
  end

  # GET /expense_reports/1
  # GET /expense_reports/1.xml
  def show
    @expense_report = ExpenseReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_report }
    end
  end

  # GET /expense_reports/new
  # GET /expense_reports/new.xml
  def new
    @expense_report = ExpenseReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_report }
    end
  end

  # GET /expense_reports/1/edit
  def edit
    @expense_report = ExpenseReport.find(params[:id])
  end

  # POST /expense_reports
  # POST /expense_reports.xml
  def create
    @expense_report = ExpenseReport.new(params[:expense_report])

    respond_to do |format|
      if @expense_report.save
        format.html { redirect_to(@expense_report, :notice => 'Expense report was successfully created.') }
        format.xml  { render :xml => @expense_report, :status => :created, :location => @expense_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_reports/1
  # PUT /expense_reports/1.xml
  def update
    @expense_report = ExpenseReport.find(params[:id])

    respond_to do |format|
      if @expense_report.update_attributes(params[:expense_report])
        format.html { redirect_to(@expense_report, :notice => 'Expense report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_reports/1
  # DELETE /expense_reports/1.xml
  def destroy
    @expense_report = ExpenseReport.find(params[:id])
    @expense_report.destroy

    respond_to do |format|
      format.html { redirect_to(expense_reports_url) }
      format.xml  { head :ok }
    end
  end
end
