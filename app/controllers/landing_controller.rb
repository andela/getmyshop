class LandingController < ApplicationController
  def index
    @categories = Category.all.limit(3)
  end

  def contact
  end

  def create_ticket
  end
end
