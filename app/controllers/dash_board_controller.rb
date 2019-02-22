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
  end
end
