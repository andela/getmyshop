RSpec.shared_examples "social share example" do |medium|
  it "redirects to social media page to share a link", js: true do
    page.execute_script "window.scrollBy(0,500)"
    social_button = "#" + medium + "-share"
    find(social_button).click
    page.within_window(windows.last) do
      text = medium + ".com"
      expect(current_url).to include(text)
    end
    windows.last.close
  end
end
