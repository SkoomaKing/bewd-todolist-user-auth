class SessionsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
    @user = User.find_by(username: params[:user][:username])

    if @user && (@user.password == params[:user][:password])
      session = @user.sessions.create
      cookies.permanent.signed[:todolist_session_token] = {
        value: session.token,
        httponly: true
      }

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  def authenticated
  end

  def destroy
  end
end
