require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }
  describe "GET index" do
    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "renders show template" do
      get :show, id: category
      expect(response).to render_template(:show)
    end
  end

  describe "#category_not_present" do
    it "returns error message" do
      get :show, id: category.name # invalid category id
      expect(response).to redirect_to(root_path)
    end
  end
end
