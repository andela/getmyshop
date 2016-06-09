class LandingController < ApplicationController
  def index
    @categories = Category.all.limit(3)
  end

  def contact
  end

  def create_ticket
  end

  def about
    render locals: { text: Faker::Lorem.paragraph(100) }
  end

  def blog
  end

  def single_post
    render locals: {
      post: params[:id].to_i
    }
  end

  def frequently_asked_questions
  end
end
