class AddressesController < ApplicationController
  def edit
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js { render "address_form" }
    end
  end

  def update
    @address = Address.update(address_params)
    redirect_to past_orders_path
  end
end
