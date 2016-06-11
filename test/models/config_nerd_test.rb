require 'test_helper'

class ConfigNerdTest < ActiveSupport::TestCase
  test "Config Nerd can be created with all parameters" do
    config_nerd = ConfigNerd.create(video_ad_id: "ad_id", video_temp_id: "temp_id", video_stream_id: "stream_id", live: true)
    assert config_nerd.valid?
  end
  
  test "Config Nerd is not valid if Video_Ad_Id Missing" do
    config_nerd = ConfigNerd.create(video_temp_id: "temp_id", video_stream_id: "stream_id", live: true)
    assert_not config_nerd.valid?
  end
end
