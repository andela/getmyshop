class LandingController < ApplicationController
  def index
    @categories = Category.all.limit(3)
  end

  def contact
  end

  def create_ticket
  end

  def about
    @text = Faker::Lorem.paragraph(100)
  end

  def blog
  end

  def single_post
    next_id = params[:id] + 1
    previous_id = params[:id] - 1
  end

  def frequently_asked_questions
  end
end
