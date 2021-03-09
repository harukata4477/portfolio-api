class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        # skip_before_action :verify_authenticity_token, if: :devise_controller?
        skip_before_action :method_name, raise: false

        before_action :split_tokens
        prepend_after_action :join_tokens
      
        private
      
          def split_tokens
            return if request.headers['X-Access-Token'].nil?
      
            token = JSON.parse(Base64.decode64(CGI.unescape(request.headers['X-Access-Token'])))
            request.headers['access-token'] = token['access-token']
            request.headers['client'] = token['client']
            request.headers['uid'] = token['uid']
          end
      
          def join_tokens
            return if response.headers['access-token'].nil?
      
            auth_json = {
              'access-token' => response.headers['access-token'],
              'client' => response.headers['client'],
              'uid' => response.headers['uid'],
            }
            response.headers.delete_if{|key| auth_json.include? key}
            response.headers['X-Access-Token'] = CGI.escape(Base64.encode64(JSON.dump(auth_json)))
          end

        # include ActionController::Cookies
        # include UserAuth::Authenticator
end
