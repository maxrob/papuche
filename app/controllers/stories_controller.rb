class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :like, :dislike, :destroy]
  before_action :own_action, only: [:destroy]

  # GET /stories
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
  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id

    @story.save ? ( redirect_to stories_path, notice: "L'histoire a bien été ajoutée." ) : ( render :edit )
  end

  def show
    @story = Story.get(story_id: params[:id])
  end

  # GET /stories/:id/like
  def like
    Like.like!(story_id: params[:story_id], user_id: current_user.id)
    render text: "Like success"
  end

  # GET /stories/:id/dislike
  def dislike
    Like.dislike!(story_id: params[:story_id], user_id: current_user.id)
    render text: "Dislike success"
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy

    @story.destroy
    redirect_to stories_path, notice: "L'histoire a été supprimée."

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
