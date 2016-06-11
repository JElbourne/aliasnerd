require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "Project can be created with all parameters" do
    project = Project.create(name: "New App", description: "This is a app", web_link: "test.com", github_link: "github.com")
    assert project.valid?
  end
  
  test "Project is not valid if Name Missing" do
    project = Project.create(description: "New App", web_link: "test.com", github_link: "github.com")
    assert_not project.valid?
  end

  test "Project is not valid if Description Missing" do
    project = Project.create(name: "New App", web_link: "test.com", github_link: "github.com")
    assert_not project.valid?
  end
 
  test "Project is not valid if Web Link Missing" do
    project = Project.create(name: "Name", description: "New App", github_link: "github.com")
    assert_not project.valid?
  end

  test "Project is not valid if github_link Missing" do
    project = Project.create(name: "New App", description: "descript", web_link: "test.com")
    assert_not project.valid?
  end

end
