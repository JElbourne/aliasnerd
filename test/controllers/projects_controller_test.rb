require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @request.env['HTTP_REFERER'] = 'http://test.host/projects'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new if Admin" do
    sign_in users(:admin)
    get :new
    assert_response :success
  end

  test "should Not get new if Not Admin" do
    get :index
    sign_in users(:subscribed)
    get :new
    assert_redirected_to projects_path
  end

  test "should Not get new if Not logged in, redirect to login page" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should create project if Admin User" do
    sign_in users(:admin)
    assert_difference('Project.count') do
      post :create, project: { description: @project.description, github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    end
    assert_redirected_to projects_path
  end

  test "should Not create project if not Admin" do
    sign_in users(:subscribed)
    assert_no_difference('Project.count') do
      post :create, project: { description: @project.description, github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    end
    assert_redirected_to projects_path
  end

  test "shouldn't create project if not valid, renders :new action" do
    sign_in users(:admin)
    assert_no_difference('Project.count') do
      ## Missing Description, should fail
      post :create, project: { github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    end
    assert_template :new
  end

  test "should get edit if Admin" do
    sign_in users(:admin)
    get :edit, id: @project
    assert_response :success
  end

  test "should Not get edit if Not Admin" do
    get :index
    sign_in users(:subscribed)
    get :edit, id: @project
    assert_redirected_to projects_path
  end

  test "should update project" do
    sign_in users(:admin)
    project_id = @project.id
    patch :update, id: @project, project: { description: "balloons" }
    @project = Project.find_by_id(project_id)
    assert_equal("balloons", @project.description)
    assert_redirected_to projects_path
  end

  test "should Not update project if Not Admin" do
    sign_in users(:subscribed)
    project_id = @project.id
    patch :update, id: @project, project: { description: "balloons" }
    @project = Project.find_by_id(project_id)
    assert_not_equal("balloons", @project.description)
    assert_redirected_to projects_path
  end

  test "should Not update project if Not Signed In, redirect to sign in page" do
    patch :update, id: @project, project: { description: @project.description, github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't update project if not valid, renders :edit action" do
    sign_in users(:admin)
    ## Invalid Name will not allow update
    patch :update, id: @project, project: {name: "?$@@$#"}
    assert_template :edit
  end

  test "should destroy project if Admin" do
    sign_in users(:admin)
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end
    assert_redirected_to projects_path
  end
  
  test "should Not destroy project if Not Admin" do
    sign_in users(:subscribed)
    assert_no_difference('Project.count') do
      delete :destroy, id: @project
    end
    assert_redirected_to projects_path
  end
end
