module Api::ErrorHandler
  extend ActiveSupport::Concern

  ERRORS = {
    'ActiveRecord::RecordNotFound' => 'Errors::NotFound',
    'JSON::ParserError' => 'Errors::BadRequest',
    'Errors::Forbidden' => 'Errors::Forbidden'
  }

  included do
    rescue_from(StandardError, with: lambda { |e| handle_error(e) }) if Rails.env.production?
  end

  private

  def handle_error(e)
    mapped = map_error(e)
    mapped ||= Errors::StandardError.new
    render_error(mapped)
  end

  def map_error(e)
    error_klass = e.class.name
    return e if ERRORS.values.include?(error_klass)
    ERRORS[error_klass]&.constantize&.new
  end

  def render_error(error)
    render json: Api::ErrorSerializer.new(error), status: error.status
  end

end
