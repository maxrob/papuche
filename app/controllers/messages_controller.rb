class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]


  # GET /messages/new
  def new
    self._fill_form
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to stories_path, notice: "Histoire continué avec succès"
    else
      self._fill_form
    end

  end


  def _fill_form

    if params[:story_id].present?

      story_id  = params[:story_id].to_i
      user_id   = current_user.id

      if Message.user_already_contribute?(user_id: user_id, story_id: story_id)
        redirect_to stories_path, notice: "Vous avez déjà contribué à l'histoire"

      elsif Message.someone_writing?(story_id: story_id)
        redirect_to stories_path, notice: "Someone writing"
      else
        Permission.create(user_id: user_id, story_id: story_id)

        # init var for view
        @story_content      = Message.get_story_content(story_id: story_id)
        @title              = Story.find(story_id).title
        @message            = Message.new(story_id: story_id, user_id: user_id )
      end

    else
      redirect_to stories_path, notice: "Histoire non identifié"
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
