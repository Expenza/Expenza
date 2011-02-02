class ReceiptsController < ApplicationController
  # GET /receipts
  # GET /receipts.xml
  before_filter :authenticate_user!
  #load_and_authorize_resource #for cancan

 # def search
  #  if params[:q].blank?
   # else
    #  @search = Receipt.search do
     #   keywords params[:q]
      #  with(:user_id).all_of [current_user.id]
     # end
    #end
  #end

  def index
    @receipts = current_user.receipts
    #@receipts = current_user.receipts

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.xml
  def show
    @receipt = Receipt.find(params[:id])
    enforce_view_permission(@receipt)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @receipt }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.xml
  def new
    @receipt = Receipt.new
    enforce_create_permission(@receipt)
    @receipt.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @receipt }
    end
  end

  # GET /receipts/1/edit
  def edit
    @receipt = Receipt.find(params[:id])
    enforce_update_permission(@receipt)
  end

  # POST /receipts
  # POST /receipts.xml
  def create
    @receipt = Receipt.new(params[:receipt])
    enforce_create_permission(@receipt)
    @receipt.user = current_user
    @receipt.date = DateTime.strptime(params[:receipt][:date],'%m/%d/%Y').to_time
    logger.debug params[:receipt].inspect

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to(@receipt, :notice => 'Receipt was successfully created.') }
        format.xml { render :xml => @receipt, :status => :created, :location => @receipt }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @receipt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.xml
  def update
    @receipt = Receipt.find(params[:id])
    enforce_update_permission(@receipt)
    params[:receipt][:date] = DateTime.strptime(params[:receipt][:date],'%m/%d/%Y').to_time
    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to(@receipt, :notice => 'Receipt was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @receipt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.xml
  def destroy
    @receipt = Receipt.find(params[:id])
    enforce_destroy_permission(@receipt)
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to(receipts_url) }
      format.xml { head :ok }
    end
  end
end
