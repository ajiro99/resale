class StockingsController < ApplicationController
  before_action :set_stockings, only: %i(index)
  before_action :set_stocking, only: %i(edit update destroy)

  def index
    @q = Stocking.ransack(params[:q])
    @stockings_q = @q.result.order(:purchase_date)
    @stockings = StockingDecorator.decorate_collection(@stockings_q)
  end

  def new
    @stocking = Stocking.new
    3.times { @stocking.stocking_products.build }
  end

  def edit; end

  def create
    @stocking = Stocking.new(stocking_params)

    if @stocking.save
      redirect_to stockings_path, notice: 'Stocking was successfully created.'
    else
      render :new
    end
  end

  def update
    if @stocking.update(update_stocking_params)
      redirect_to stockings_path, notice: 'Stocking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @stocking.destroy
      redirect_to stockings_url, notice: 'Stocking was successfully destroyed.'
    else
      set_stockings
      render :index
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
