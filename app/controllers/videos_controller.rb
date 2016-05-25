class VideosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_required, except: [:index, :show]
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = if params[:project]
                Video.where(project_id: params[:project])
              else
                Video.all
              end
    @project = params.has_key?(:project) ? Project.find(params[:project]) : nil
  end

  def show

  end

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'Video was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to videos_path, notice: 'Video was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
    end
  end

  private
    def set_video
      @video = Video.friendly.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:name, :description, :video_source_id, :project_id)
    end
end
