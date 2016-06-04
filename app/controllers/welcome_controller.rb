class WelcomeController < ApplicationController
  def index
    @projects = Project.limit(3)
    @subs_count = User.get_subs_count
    @video_home_id = if @config_nerd.live
                       @config_nerd.live
                     else
                       if @config_nerd.video_temp_id
                         @config_nerd.video_temp_id
                       else
                         @config_nerd.video_ad_id
                       end
                     end
  end
end
