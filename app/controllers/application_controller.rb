class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    head :not_found
  end
end
