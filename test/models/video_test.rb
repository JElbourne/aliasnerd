require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  setup do
    @params = {
      name: "New Video",
      description: "This is a video",
      video_source_id: "sdf323asfd"
    }
  end

  test "Video can be created with all parameters" do
    video = Video.create(@params)
    assert video.valid?
  end
  
  test "Video is not valid if Name Missing" do
    video = Video.create(@params.except(:name))
    assert_not video.valid?
  end

  test "Video is not valid if Description Missing" do
    video = Video.create(@params.except(:description))
    assert_not video.valid?
  end
 
  test "Video is not valid if Video Source Missing" do
    video = Video.create(@params.except(:video_source_id))
    assert_not video.valid?
  end
end
