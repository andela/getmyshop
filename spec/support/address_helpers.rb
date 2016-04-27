module AddressHelpers
  def fill_in_address
    address = build(:address)
    fill_in_personal_info(address)
    fill_in_location_info(address)
  end

  def fill_in_location_info(address)
    fill_in "Landmark", with: address.landmark
    fill_in "City", with: address.city
    fill_in "State", with: address.state
    fill_in "Country", with: address.country
  end

  def fill_in_personal_info(address)
    fill_in "name", with: address.name
    fill_in "Email", with: address.email
    fill_in "Address", with: address.address
    fill_in "Phone", with: address.phone
  end
end
