class AddressesController < ApplicationController
  def edit
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js { render "edit_address_form" }
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update_attributes(address_params)
      redirect_to addresses_users_path(address.user)
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.delete
    flash[:success] = "Address deleted"
    redirect_to addresses_users_path(address.user)
  end

  protected

  def address_params
    params.require(:address).permit(
      :id,
      :user_id,
      :name,
      :email,
      :address,
      :landmark,
      :gender,
      :phone,
      :state,
      :city,
      :country
    )
  end
end
