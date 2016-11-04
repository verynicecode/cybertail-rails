class Api::V1::HooksController < ApplicationController
  before_action :ensure_user
  expose(:hooks) { Hook.where(suppress: false) }

  private

  def current_user
    @current_user ||= User.find_by token: params[:token]
  end

  def ensure_user
    head :not_found unless current_user
  end
end
