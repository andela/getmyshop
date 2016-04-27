class AddressesController < ApplicationController
  def edit
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js { render "edit_address_form" }
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(address_params)
    session[:address_id] = @address.id
    redirect_to "/orders/summary"
    end
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
