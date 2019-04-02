class DashBoardController < ApplicationController
  def index
    # 在庫
    sp = StockingProduct.arel_table
    p = Product.arel_table
    @total_stocks = StockingProduct.in_stock.joins(:product)
                                   .group('products.type')
                                   .select(
                                     p[:type].as('product_type'),
                                     sp[:estimated_price].count().as('count'),
                                     sp[:estimated_price].sum.as('estimated_price'),
                                   ).decorate

    # 今月の仕入
    s = Stocking.arel_table
    @stocking_of_this_months = Stocking.this_month
                                       .group(:purchase_place)
                                       .select(
                                         s[:purchase_place],
                                         s[:purchase_place].count().as('count'),
                                         s[:use_points].sum.as('use_points'),
                                         s[:purchasing_cost].sum.as('purchasing_cost')
                                       ).union(
                                         Stocking.this_month
                                           .select(
                                             999,
                                             s[:purchase_place].count().as('count'),
                                             s[:use_points].sum.as('use_points'),
                                             s[:purchasing_cost].sum.as('purchasing_cost')
                                           )
                                       ).decorate

    # 今月の売上
    s = Sale.arel_table
    @sale_of_this_months = Sale.this_month
                               .group(:account)
                               .select(
                                 s[:account],
                                 s[:account].count().as('count'),
                                 s[:selling_price].sum.as('selling_price'),
                                 s[:profit].sum.as('profit')
                               ).union(
                                 Sale.this_month
                                     .select(
                                       999,
                                       s[:account].count().as('count'),
                                       s[:selling_price].sum.as('selling_price'),
                                       s[:profit].sum.as('profit')
                                     )
                               ).decorate

    # 月別の売上
    @sale_of_monthly = Sale.this_year
                           .group('strftime("%Y", sales_date)')
                           .group('strftime("%m", sales_date)')
                           .select(
                             s[:selling_price].sum.as('selling_price'),
                             s[:profit].sum.as('profit'),
                             s[:sales_date],
                             s[:sales_date].count().as('count')
                           ).decorate

    # 年別の売上
    @sale_of_by_year = Sale.group('strftime("%Y", sales_date)')
                           .select(
                             s[:selling_price].sum.as('selling_price'),
                             s[:profit].sum.as('profit'),
                             s[:sales_date],
                             s[:sales_date].count().as('count')
                           ).union(
                             Sale.select(
                               s[:selling_price].sum.as('selling_price'),
                               s[:profit].sum.as('profit'),
                               999,
                               s[:sales_date].count().as('count')
                             )
                           ).decorate

    sales = Sale.target_aggregation
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
