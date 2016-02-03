class CartsController < ApplicationController
  def index
    @order = Order.new
    2.times { @order.order_items.build }
    @cartproducts = [
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
      }
    ]
  end

  def add_to
  end
end
