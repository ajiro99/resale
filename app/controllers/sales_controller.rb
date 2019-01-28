class SalesController < ApplicationController
  before_action :set_sale, only: %i(edit update destroy)

  def index
    @sales = Sale.all.order(:sales_date)
    # @q = Sale.ransack(params[:q])
    # @sales = @q.result.order(:sales_date)
  end

  def new
    @sale = Sale.new
  end

  def edit
    @sale = Sale.find(params[:id])
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
  end

  def create
    Sale.transaction do
      @sale = Sale.new(sale_params)

      respond_to do |format|
        if @sale.save
          update_stock(@sale)
          format.html { redirect_to sales_path, notice: 'Sale was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  rescue => e
    render plain: e.message
  end

  def update
    Sale.transaction do
      respond_to do |format|
        if @sale.update(sale_params)
          update_stock(@sale)
          format.html { redirect_to sales_path, notice: 'Sale was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  rescue => e
    render plain: e.message
  end

  def destroy
    Sale.transaction do
      set_in_stock(@sale.id)
      @sale.destroy

      respond_to do |format|
        format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      end
    end
  rescue => e
    render plain: e.message
  end

  def search
    @q = Sale.search(search_params)
    @sales = @q.result.order(:sales_date)
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
      :target_body, :target_lense_1, :target_lense_2
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
