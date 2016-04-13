module V1
  class UsersController < BaseController

    def_param_group :user do
      param :user, ActionController::Parameters, :required => true, :action_aware => true do
        param :first_name, String, "First name", :required => true
        param :last_name, String, "Last name", :required => true
        param :email, String, "Email", required: true
        param :password, String, "Password", required: false
      end
    end


    api :POST, "/v1/users", "Create a user"
    param_group :user
    def create
binding.pry 
      if params[:cloudId].present?   
        if params[:provider].present?
          u = User.from_external(underscore_keys_for(params))
        else
          u = User.create(user_params)
        end
        if u.persisted?
          generate_authentication_token_for u
          head :ok and return
        else
          render json: { errors: u.to_api_errors }, status: :bad_request
        end
      else
        render_api_error api_controller_error('invalid_cloud_id', controller: 'sessions')
      end
    end

    api :GET, "/v1/users/:userId", "Show a user"
    def show
      @user = User.find(params[:userId])

      render json: @user
    end

    private 

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name)
    end
  end
end