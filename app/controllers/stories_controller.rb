class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :like, :dislike, :destroy]
  before_action :own_action, only: [:destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories_top = Story.top_finished.page params[:page]
    @stories_finished = Story.all_finished.page params[:page]
    @stories_unfinished = Story.all_unfinished.page params[:page]
    @stories_random = Story.random.page params[:page]
  end

  # GET /stories/new
  def new
    @story = Story.new
    render :edit
  end


  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id

    respond_to do |format|
      if @story.save
        format.html { redirect_to stories_path, notice: "L'histoire a bien été ajoutée." }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    Like.like!(story_id: params[:story_id], user_id: current_user.id)
    render text: "Like success"
  end

  def dislike
    Like.dislike!(story_id: params[:story_id], user_id: current_user.id)
    render text: "Dislike success"
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy

    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_path, notice: "L'histoire a été supprimée." }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Restrict own update about own Objects
    def own_action
      if @story.user_id != current_user.id
        redirect_to @story, notice: "Vous n'avez pas les droits necessaires"
      end
    end


    def story_params
      params[:story].permit(:title, :content, :id_user)
    end
end
