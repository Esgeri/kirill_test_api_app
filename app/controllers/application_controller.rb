class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def render_resource(resource)
    if resource.errors.empty?
      payload = { user_id: resource.id }
      token = encode_token(payload)
      render json: { auth_token: token }
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def encode_token(payload)
    JWT.encode(payload, 'my_secret')
  end
end
