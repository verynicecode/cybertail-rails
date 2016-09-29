class HerokuHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    message = "#{params['app']} had release #{params['release']} deployed by #{params['user']}."
    url = "https://dashboard.heroku.com/apps/#{params['app']}"

    {
      service: Service.heroku,
      payload: params.to_unsafe_hash,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end