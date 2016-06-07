class ConfigNerdsController < ApplicationController
  before_action :authenticate_user! 
  before_action :admin_required
  def edit

  end

  def update
    respond_to do |format|
      if @config_nerd.update(config_nerd_params)
        format.html { redirect_to edit_config_nerd_path, notice: 'Configuration was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  
  def config_nerd_params
    params.require(:config_nerd).permit(:video_ad_id, :video_temp_id, :video_stream_id, :live)
  end
end
