module UsersHelper
  def display_addresses
    if @user_addresses.empty?
      render partial: "noaddress"
    else
      render partial: "addresses"
    end
  end

  def default_address
    if current_user.addresses.empty?
      render partial: "noaddress"
    else
      @address = current_user.addresses.last
      render partial: "address"
    end
  end
end
