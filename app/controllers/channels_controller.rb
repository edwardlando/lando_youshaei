class ChannelsController < ApplicationController

  # before_filter :authenticate_user!
  before_filter :user_is_admin, :only => [:index]

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @channels }
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    # The show logic is now implemented in the store#index
    @user = current_user
    @channel = current_user.current_channel
    @channel_items = @channel.channel_items

    @channel.item_index = params[:index]
    @channel.save
    
    @current_item = @channel.channel_items[@channel.item_index] #problem if new channel with no items

    respond_to do |format|
      format.html { redirect_to root_path }        
      format.json  #render :json => @current_item}
    end
  end

  # GET /channels/new
  # GET /channels/new.json
  def new
    @channel = Channel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @channel }
    end
  end

  # GET /channels/1/edit
  def edit
    @channel = Channel.find(params[:id])
  end

  # POST /channels
  # POST /channels.json
  def create
    genes_str = "2.5,2.5,2.5,2.5,2.5,"
    genes_str += genes_str
    genes_str += genes_str
    @channel = Channel.new(:gender => params[:channel][:gender],
                           :price => params[:channel][:price],
                           :vibe => params[:channel][:vibe],
                           :apparel => params[:channel][:apparel])

    if guest_user
      @channels = Channel.find_all_by_guest_user_id(guest_user.lazy_id)
      @channel.guest_user_id = guest_user.lazy_id
    else
      @channels = current_user.channels
      @channel.user_id = current_user.id
    end

    @channel.item_index = 0
     
    @channels.each do |c|
      if c.current_channel == true
        @old_channel = c
        @old_channel.current_channel = false
        @old_channel.save
      end
    end
 
    @channel.current_channel = true
   
    respond_to do |format|
      if @channel.save
        format.html { redirect_to :controller => "store", :action => "index", 
        :switch => "true", :current_channel => @channel.id, :notice => 'Channel was successfully created.' }
        format.json { }#render :json => @channel, :status => :created, :location => @channel }
      else
        format.html { redirect_to root_path, :notice => 'Oops' }
        format.json { }#render :json => @channel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /channels/1
  # PUT /channels/1.json
  def update
    @channel = Channel.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to @channel, :notice => 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @channel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end

  private 

  def user_is_admin
    unless current_user.role == "admin"
      redirect_to :controller => "store", :action => "index"
    end
  end
  
end
