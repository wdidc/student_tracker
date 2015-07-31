module StatusesHelper
  def current_user
    @user = User.find_by(uid: session[:uid])
  end
end
