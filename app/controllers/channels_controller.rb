class ChannelsController < ApplicationController

  # before_filter :authenticate_user!

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

    @channels = Channel.all
    @channel = Channel.new(:name => params["channel"]["name"], :color => params["channel"]["color"], 
      :style => params["channel"]["style"], :price => params["channel"]["price"],
      :gender => params["channel"]["gender"])
    
    # Users who are logged in
    @channel.user_id = current_user.id
  
    @channel.item_index = 0
       
    if @channel.save
      @channels.each do |channel|
        channel.update_attributes(:current_channel => false)
      end
      @channel.current_channel = true
      unless @channel.channel_items.nil?
      @current_item = @channel.channel_items[@channel.item_index]
      end
    end

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, :notice => 'Channel was successfully created.' }
        format.js
        format.json { render :json => @channel, :status => :created, :location => @channel }
      else
        format.html { render :action => "new" }
        format.json { render :json => @channel.errors, :status => :unprocessable_entity }
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




end
