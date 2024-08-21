module Api
    module V1
      class AuthController < ApplicationController
        def sign_in
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            tokens = user.generate_tokens
            
            # Custom response format
            render json: {
              "access-token" => tokens[:"access-token"],
              "token-type" => "Bearer",
              "client" => tokens[:"client"],
              "expiry" => tokens[:"expiry"],
              "uid" => tokens[:"uid"]
            }, status: :ok
          else
            render json: { error: 'Invalid credentials' }, status: :unauthorized
          end
        end
      end
    end
  end
  