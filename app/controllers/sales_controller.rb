class SalesController < ApplicationController
  before_action :set_sale, only: %i(edit update destroy)

  def index
    @q = Sale.ransack(params[:q])
    @sales_q = @q.result.order(:sales_date)
    @sales = SaleDecorator.decorate_collection(@sales_q)
  end

  def new
    @sale = Sale.new
    @sale.sale_extras.build
  end

  def edit
    @sale.stocking_products.map do |stocking_product|
      @sale.target_body = stocking_product.id if stocking_product.product.type == 'Body'

      if stocking_product.product.type == 'Lense'
        if @sale.target_lense_1.blank?
          @sale.target_lense_1 = stocking_product.id
        else
          @sale.target_lense_2 = stocking_product.id
        end
      end
    end
    @sale.sale_extras.build
  end

  def create
    Sale.transaction do
      @sale = Sale.new(sale_params)
      if @sale.save
        update_stock(@sale)
        redirect_to sales_path, notice: 'Sale was successfully created.'
      else
        render :new
      end
    end
  rescue => e
    @sale.errors.add(:base, e.message)
    render :new
  end

  def update
    Sale.transaction do
      @sale.sale_extras.destroy_all
      @sale.update!(sale_params)
      update_stock(@sale)
      redirect_to sales_path, notice: 'Sale was successfully updated.'
    end
  rescue => e
    @sale.errors.add(:base, e.message)
    render :edit
  end

  def destroy
    Sale.transaction do
      set_in_stock(@sale.id)
      @sale.destroy
      redirect_to sales_url, notice: 'Sale was successfully destroyed.'
    end
  rescue => e
    render plain: e.message
  end

  def search
    # @q = Sale.search(search_params)
    # @sales = @q.result.order(:sales_date)

    @q = Sale.search(search_params)
    @sales_q = @q.result.order(:sales_date)
    @sales = SaleDecorator.decorate_collection(@sales_q)
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(
      :sales_date, :product_type, :stocking_price, :bonus_price, :cost,
      :selling_price, :fee, :shipping_cost, :sales, :profit, :profit_rate,
      :status, :remarks, :sales_channel, :account,
      :target_body, :target_lense_1, :target_lense_2,
      sale_extras_attributes:
        %i(extra_id)
    )
  end

  def update_stock(sale)
    set_in_stock(sale.id)
    products_ids = []
    products_ids << sale.target_body.to_i if sale.target_body.present?
    products_ids << sale.target_lense_1.to_i if sale.target_lense_1.present?
    products_ids << sale.target_lense_2.to_i if sale.target_lense_2.present?
    StockingProduct.where(id: products_ids).update_all(sale_id: sale.id) if products_ids.present?
  end

  def set_in_stock(sale_id)
    StockingProduct.where(sale_id: sale_id).update_all(sale_id: nil)
  end

  def search_params
    params.require(:q).permit!
  end
end
