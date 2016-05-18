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

  test "Video's name must not contain invalid characters" do
    @video = videos(:one)

    video = @video.update(name: "Ms. Jan Levinson-Gould" )
    assert video, 'The video should be valid with the name Ms. Jan Levinson-Gould'
    
    video = @video.update(name: "Dr. Martin Luther King, Jr." )
    assert video, 'The video should be valid with the name Dr. Martin Luther King, Jr.'
    
    video = @video.update(name: "Brett d'Arras-d'Haudracey" )
    assert video, "The video should be valid with the name Brett d'Arras-d'Haudracey"
    
    video = @video.update(name: "Brüno" )
    assert video, "The video should be valid with the name Brüno"
    
    video = @video.update(name: "John Doe" )
    assert video, "The video should be valid with the name John Doe"
    
    video = @video.update(name: "Mary-Jo Jane Sally Smith" )
    assert video, "The video should be valid with the name Mary-Jo Jane Sally Smith"
    
    video = @video.update(name: "Fatty Mc.Error$" )
    assert_not video, "The video should not be valid with the name Fatty Mc.Error$"
  
    video = @video.update(name: "FA!L" )
    assert_not video, "The video should not be valid with the name FA!L"
  
    video = @video.update(name: "#arold Newm@n" )
    assert_not video, "The video should not be valid with the name #arold Newm@n"
  
    video = @video.update(name: "N4m3 w1th Numb3r5" )
    assert_not video, "The video should not be valid with the name N4m3 w1th Numb3r5"
  
  end
end
