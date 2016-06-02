module WelcomeHelper
  def liked_button
    if Voter.has_voted?(@config_nerd, cookies.signed[:voting_id]) 
      content_tag(:button, class: "btn btn-success btn-sm") do
        content_tag(:span, nil, class: "glyphicon glyphicon-heart") +
        " I liked This"
      end
    else
      link_to vote_up_path, method: :post, class: "btn btn-primary btn-sm" do
        content_tag(:span, nil, class: "glyphicon glyphicon-heart") +
        " Like This"
      end
    end
  end 
end
