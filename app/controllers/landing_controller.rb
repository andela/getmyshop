class LandingController < ApplicationController
  def index
    @categories = ["Fashion", "Electronics", "Home and Kitchen"]
    @products = [
      [
        { image: "http://i.imgur.com/QsgYAlQ.png",
          text: "Sling-Back Stilletos",
          price: "N5000"
        },
        {
          image: "http://i.imgur.com/JQOY8u9.jpg",
          text: "Beautiful Summer Hat",
          price: "N1400"
        },
        {
          image: "http://i.imgur.com/Pqlmpic.jpg",
          text: "Brown Satchel Bag",
          price: "N4600"
        },
        { image: "http://i.imgur.com/QsgYAlQ.png",
          text: "Sling-Back Stilletos",
          price: "N5000"
        }
      ],
      [
        { image: "http://i.imgur.com/6VuVwkr.jpg",
          text: "Two-way fan",
          price: "N2000"
        },
        {
          image: "http://i.imgur.com/kh6zWa5.jpg",
          text: "Mini-USB charger",
          price: "N750"
        },
        {
          image: "http://i.imgur.com/ToxiFz1.png",
          text: "Sony Alpha 7 digital camera",
          price: "N46000"
        },
        { image: "http://i.imgur.com/YYnFLrm.png",
          text: "Sling-Back Stilletos",
          price: "N5000"
        }
      ],
      [
        { image: "http://i.imgur.com/16vrQzW.jpg",
          text: "Set of Pots",
          price: "N8200"
        },
        {
          image: "http://i.imgur.com/hBjUwMG.jpg",
          text: "Turkish Silverware",
          price: "N12900"
        },
        {
          image: "http://i.imgur.com/iIh0TUB.jpg",
          text: "Garaert Electric Kettle",
          price: "N46000"
        },
        { image: "http://i.imgur.com/16vrQzW.jpg",
          text: "Set of Pots",
          price: "N8200"
        }
      ]
    ]
  end

  def contact
  end

  def create_ticket
  end
end
