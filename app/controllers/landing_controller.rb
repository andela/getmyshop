class LandingController < ApplicationController
  def index
  end

  def shop
    redirect_to root_path unless @shop
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
