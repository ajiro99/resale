class StockingsController < ApplicationController
  before_action :set_stocking, only: %i(edit update destroy)

  def index
    @stockings = Stocking.all.order(:purchase_date)
  end

  def new
    @stocking = Stocking.new
    3.times { @stocking.stocking_products.build }
  end

  def edit
    @stocking = Stocking.find(params[:id])
    t = 3 - @stocking.stocking_products.size.to_i
    t.times { @stocking.stocking_products.build }
  end

  def create
    @stocking = Stocking.new(stocking_params)

    respond_to do |format|
      if @stocking.save
        format.html { redirect_to stockings_path, notice: 'Stocking was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @stocking.update(update_stocking_params)
        # TODO: ajaxで削除できるように今後修正する

        @stocking.stocking_products.map do |stocking_product|
          stocking_product.destroy if stocking_product.product_id.blank?
        end

        format.html { redirect_to stockings_path, notice: 'Stocking was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @stocking.destroy
    respond_to do |format|
      format.html { redirect_to stockings_url, notice: 'Stocking was successfully destroyed.' }
    end
  end

  private

  def set_stocking
    @stocking = Stocking.find(params[:id])
  end

  def stocking_params
    params.require(:stocking).permit(
      :purchase_date, :product_type, :purchase_price, :shipping_cost,
      :use_points, :purchasing_cost, :payment_type, :purchase_place, :remarks,
      stocking_products_attributes:
        %i(product_id color estimated_price)
    )
  end

  def update_stocking_params
    params.require(:stocking).permit(
      :purchase_date, :product_type, :purchase_price, :shipping_cost,
      :use_points, :purchasing_cost, :payment_type, :purchase_place, :remarks,
      stocking_products_attributes:
        %i(product_id color estimated_price destroy id)
    )
  end
end
