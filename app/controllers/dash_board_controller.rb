class DashBoardController < ApplicationController
  def index
    @total_stocks = StockingProduct.in_stock
    @stocking_of_this_months = Stocking.this_month
    @sale_of_this_months = SalesDecorator.decorate(Sale.this_month)

    j = Sale.arel_table
    sale_of_this_year = Sale.this_year
    @sale_of_this_year = SalesDecorator.decorate(sale_of_this_year)
    @sale_of_monthly = SaleDecorator.decorate_collection(
      sale_of_this_year.group('strftime("%Y", sales_date)')
      .group('strftime("%m", sales_date)')
      .select(
        j[:selling_price].sum.as('selling_price'),
        j[:profit].sum.as('profit'),
        j[:sales_date]
      )
    )

    @sale_of_by_year = SaleDecorator.decorate_collection(
      Sale.group('strftime("%Y", sales_date)')
      .select(
        j[:selling_price].sum.as('selling_price'),
        j[:profit].sum.as('profit'),
        j[:sales_date]
      )
    )

    @all_sales = SaleDecorator.decorate_collection(Sale.all)

    sales = Sale.where('sales_date >= ? ', '2019-01-01 00:00:00')
    @week_count = Array.new(7, 0)
    @day_count = Array.new(31, 0)

    sales.map do |sale|
      @week_count[sale.sales_date.wday] += 1
      @day_count[sale.sales_date.day - 1] += 1
    end

    @week_proportion = count_to_percentage(@week_count, sales.size)
    @day_proportion = count_to_percentage(@day_count, sales.size)
  end

  private

  def count_to_percentage(counts, sales_size)
    proportion = []
    counts.map do |count|
      proportion << ActionController::Base.helpers.number_to_percentage(
        count.fdiv(sales_size) * 100, precision: 0
      )
    end
    proportion
  end
end
