require 'rails_helper'

RSpec.describe ShopController, type: :controller do
	describe 'signup page' do
	  context 'when user requests signup url' do
	  	it 'returns a 200 status code' do
	  		get :signup
	  		expect(response.status).to eql(200)
	  	end

	  	it 'loads the signup page' do
	  		get :signup
	  		expect(response).to render_template(:200)
	  	end
	  end
	end
end
