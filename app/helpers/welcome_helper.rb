module WelcomeHelper
  def liked_button
    if current_user.liked 
      content_tag(:button, class: "btn btn-success btn-sm") do
        content_tag(:span, nil, class: "glyphicon glyphicon-heart") +
        " I liked This"
      end
    else
      link_to liked_path, method: :patch, class: "btn btn-primary btn-sm" do
        content_tag(:span, nil, class: "glyphicon glyphicon-heart") +
        " Like This"
      end
    end
  end 
end
