module LoginHelper
  def login(user)
    old_controller = @controller
    @controller = SessionsController.new
    post :create, session: { email: user.email, password: user.password }
    @controller = old_controller
  end
end
