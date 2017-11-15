class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def display_errors(klass)
    klass.errors.full_messages.join(', ').to_s
  rescue
    klass.full_messages.join(', ').to_s
  end
end
