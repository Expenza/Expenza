class ExpenseLinesController < ApplicationController
  # GET /expense_lines
  # GET /expense_lines.xml
  before_filter :authenticate_user!
  def index
    @expense_lines = ExpenseLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_lines }
    end
  end

  # GET /expense_lines/1
  # GET /expense_lines/1.xml
  def show
    @expense_line = ExpenseLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_line }
    end
  end

  # GET /expense_lines/new
  # GET /expense_lines/new.xml
  def new
    @expense_line = ExpenseLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_line }
    end
  end

  # GET /expense_lines/1/edit
  def edit
    @expense_line = ExpenseLine.find(params[:id])
  end

  # POST /expense_lines
  # POST /expense_lines.xml
  def create
    @expense_line = ExpenseLine.new(params[:expense_line])

    respond_to do |format|
      if @expense_line.save
        format.html { redirect_to(@expense_line, :notice => 'Expense line was successfully created.') }
        format.xml  { render :xml => @expense_line, :status => :created, :location => @expense_line }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_lines/1
  # PUT /expense_lines/1.xml
  def update
    @expense_line = ExpenseLine.find(params[:id])

    respond_to do |format|
      if @expense_line.update_attributes(params[:expense_line])
        format.html { redirect_to(@expense_line, :notice => 'Expense line was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_lines/1
  # DELETE /expense_lines/1.xml
  def destroy
    @expense_line = ExpenseLine.find(params[:id])
    @expense_line.destroy

    respond_to do |format|
      format.html { redirect_to(expense_lines_url) }
      format.xml  { head :ok }
    end
  end
end
