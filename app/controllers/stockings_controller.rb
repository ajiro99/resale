class StockingsController < ApplicationController
  before_action :set_stockings, only: %i(index)
  before_action :set_stocking, only: %i(edit update destroy)

  def index; end

  def new
    @stocking = Stocking.new
    3.times { @stocking.stocking_products.build }
  end

  def edit; end

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
        format.html { redirect_to stockings_path, notice: 'Stocking was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @stocking.destroy
        format.html { redirect_to stockings_url, notice: 'Stocking was successfully destroyed.' }
      else
        set_stockings
        format.html { render :index }
      end
    end
  end

  private

  def set_stockings
    @stockings = StockingDecorator.decorate_collection(Stocking.all.order(:purchase_date))
  end

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
