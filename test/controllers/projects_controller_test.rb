require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @user = users(:subscribed)
    @project = projects(:one)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { description: @project.description, github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    end

    assert_redirected_to projects_path
  end

  test "shouldn't create project if not valid, renders :new action" do
    assert_no_difference('Project.count') do
      ## Missing Description, should fail
      post :create, project: { github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    end
    assert_template :new
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { description: @project.description, github_link: @project.github_link, name: @project.name, web_link: @project.web_link }
    assert_redirected_to projects_path
  end

  test "shouldn't update project if not valid, renders :edit action" do
    ## Invalid Name will not allow update
    patch :update, id: @project, project: {name: "?$@@$#"}
    assert_template :edit
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
