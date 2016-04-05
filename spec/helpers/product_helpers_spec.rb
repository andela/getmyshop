require "rails_helper"
RSpec.describe SearchHelper, type: :helper do
  before(:all) do
    create_list(:product, 3)
  end
  it "should return all categories" do
    expect(helper.filter_categories).to include([Product.first.category.name])
  end

  it "should return all subcategories" do
    expect(helper.filter_subcategories(Subcategory.get_unique)).to include(
      [Product.first.subcategory.name])
  end
end
