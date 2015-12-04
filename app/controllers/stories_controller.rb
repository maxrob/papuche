class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end


  # GET /stories/new
  def new
    @story = Story.new
    render :edit
  end

  # GET /stories/1/edit
  def edit
    if @story.user_id != current_user.id
      redirect_to stories_path, notice: "Modification impossible."
    end
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

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy

    if @story.user_id != current_user.id
      redirect_to stories_path, notice: "Suppression impossible."
    else
      @story.destroy
      respond_to do |format|
        format.html { redirect_to stories_path, notice: "L'histoire a été supprimée." }
        format.json { head :no_content }
      end
    end

  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end


    def story_params
      params[:story].permit(:title, :content, :id_user)
    end
end
