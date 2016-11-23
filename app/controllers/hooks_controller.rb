class HooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose :project, find_by: :token, id: :project_token

  def create
    parser.parse *args
    head :created
  end

  private

  def parser
    project.service.parser.constantize
  end

  def args
    [github_event, params].compact
  end

  def github_event
    request.headers['X-GitHub-Event']
  end
end
