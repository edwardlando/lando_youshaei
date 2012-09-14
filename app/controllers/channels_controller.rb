class ChannelsController < ApplicationController
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
    @channel = current_user.channels.first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @channel }
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
    @channel = Channel.new(params[:channel])
    @channel.user_id = current_user.id

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, :notice => 'Channel was successfully created.' }
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

  ###########################################################################################
  ###########################################################################################
  ###########################################################################################

  # NEXT action to discover items


  ##### needs to be refined a lot - if not items fit this searchm give the next best thing
  ##### also need to take votes into account


  def next
    @channel = current_channel
    @items = Item.all
    @channel_items = @items.find_all { |item| item.color = channel.color, item.style = channel.style
    item.price = channel.price, item.gender = channel.gender }
    @next_item = @channel_items.first

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { render :json => @next_item }    # Not quite sure what to do here
    end
  end






end