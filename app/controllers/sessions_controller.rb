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
    token = cookies.permanent.signed[:todolist_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user

      render json: {
        authenticated: true,
        username: user.username
      }
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
  end
end
