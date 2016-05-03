json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :web_link, :github_link
  json.url project_url(project, format: :json)
end
