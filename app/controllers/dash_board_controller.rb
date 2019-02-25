class DashBoardController < ApplicationController
  def index
    @total_stocks = StockingProduct.in_stock
    @stocking_of_this_months = Stocking.this_month
    @sale_of_this_months = Sale.this_month

    j = Sale.arel_table
    @sale_of_this_year = Sale.this_year
    @sale_of_monthly = @sale_of_this_year.group('strftime("%Y", sales_date)')
                                         .group('strftime("%m", sales_date)')
                                         .select(
                                           j[:selling_price].sum.as('selling_price'),
                                           j[:profit].sum.as('profit'),
                                           j[:sales_date]
                                         )

    @sale_of_by_year = Sale.group('strftime("%Y", sales_date)')
                           .select(
                             j[:selling_price].sum.as('selling_price'),
                             j[:profit].sum.as('profit'),
                             j[:sales_date]
                           )

    sales = Sale.where('sales_date >= ? ', '2019-01-01 00:00:00')
    @week_count = [0, 0, 0, 0, 0, 0, 0]
    @day_count = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    sales.map do |sale|
      @week_count[sale.sales_date.wday] += 1
      @day_count[sale.sales_date.day - 1] += 1
    end

    @week_proportion = []
    @week_count.map do |count|
      @week_proportion << ActionController::Base.helpers.number_to_percentage(
        count.fdiv(sales.size) * 100, precision: 0
      )
    end

    @day_proportion = []
    @day_count.map do |count|
      @day_proportion << ActionController::Base.helpers.number_to_percentage(
        count.fdiv(sales.size) * 100, precision: 0
      )
    end
  end
end
