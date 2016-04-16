module UsersHelper
  def display_addresses
    if @user_addresses.empty?
      render partial: "noaddress"
    else
      render partial: "addresses"
    end
  end

  def default_address
    if current_user.addresses
      @address = current_user.addresses.last
      render partial: "address"
    else
      render partial: "noaddress"
    end
  end
end
