class ApplicationController < ActionController::API
  # before_action :authenticate_user!

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

  def session_user
    decode_hash = decode_token
    if decode_hash.present?
      user_id = decode_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    else
      nil
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end
end
