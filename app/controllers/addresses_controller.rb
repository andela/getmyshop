class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    address = Address.new(address_params)
    address.user = current_user
    address.save
    redirect_to addresses_users_path(current_user), notice: "Address Added"
  end

  def edit
    @address = Address.find_by(id: params[:id])
    render "new"
  end

  def update
    address = Address.find_by(id: params[:id])
    address.update(address_params)
    redirect_to addresses_users_path(current_user), notice: "Address Updated"
  end

  def destroy
    address = Address.find_by(id: params[:id])
    address.destroy
    redirect_to addresses_users_path(current_user), notice: "Address Deleted"
  end

  def address_params
    params.require(:address).permit(
      :name,
      :email,
      :address,
      :landmark,
      :phone,
      :state,
      :city,
      :country
    )
  end
end
