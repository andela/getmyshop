require 'rails_helper'

RSpec.describe ShopController, type: :controller do
	describe 'signup page' do
	  context 'when user requests signup url' do
	  	it 'returns a 200 status code' do
	  		get :new
	  		expect(response.status).to eql(200)
	  	end

	  	it 'loads the signup page' do
	  		get :new
	  		expect(response).to render_template(:new)
	  	end
	  end
	end
end
