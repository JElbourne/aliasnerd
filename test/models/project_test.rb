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

  test "Project's name must not contain invalid characters" do
    @project = projects(:one)

    project = @project.update(name: "Ms. Jan Levinson-Gould" )
    assert project, 'The project should be valid with the name Ms. Jan Levinson-Gould'
    
    project = @project.update(name: "Dr. Martin Luther King, Jr." )
    assert project, 'The project should be valid with the name Dr. Martin Luther King, Jr.'
    
    project = @project.update(name: "Brett d'Arras-d'Haudracey" )
    assert project, "The project should be valid with the name Brett d'Arras-d'Haudracey"
    
    project = @project.update(name: "Brüno" )
    assert project, "The project should be valid with the name Brüno"
    
    project = @project.update(name: "John Doe" )
    assert project, "The project should be valid with the name John Doe"
    
    project = @project.update(name: "Mary-Jo Jane Sally Smith" )
    assert project, "The project should be valid with the name Mary-Jo Jane Sally Smith"
    
    project = @project.update(name: "Fatty Mc.Error$" )
    assert_not project, "The project should not be valid with the name Fatty Mc.Error$"
  
    project = @project.update(name: "FA!L" )
    assert_not project, "The project should not be valid with the name FA!L"
  
    project = @project.update(name: "#arold Newm@n" )
    assert_not project, "The project should not be valid with the name #arold Newm@n"
  
    project = @project.update(name: "N4m3 w1th Numb3r5" )
    assert_not project, "The project should not be valid with the name N4m3 w1th Numb3r5"
  
  end
end
