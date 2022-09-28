module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = user_from_remember_token(remember_token)
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def remember_token
      cookies.signed[Clearance.configuration.cookie_name.freeze]
    end

    def user_from_remember_token(token)
      Clearance.configuration.user_model.where(remember_token: token).first
    end
  end
end
