class DashBoardController < ApplicationController
  def index
    @total_stock = StockingProduct.in_stock
  end
end
