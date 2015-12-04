class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]


  # GET /messages/new
  def new
    self.fill_form
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to stories_path, notice: "Histoire continué avec succès"
    else
      self.fill_form
    end

  end


  def fill_form
    if params[:story_id].present?

      story_id = params[:story_id].to_i

      @story_content      = Message.get_story_content(story_id: story_id)
      @title              = Story.find(story_id).title
      @message            = Message.new(story_id: story_id, user_id: current_user.id )

    else
      redirect_to stories_path, notice: "Story ID undefined"
    end
  end


  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params[:message].permit(:content, :user_id, :story_id)
  end

end
