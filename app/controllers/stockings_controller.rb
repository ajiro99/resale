class StockingsController < ApplicationController
  before_action :set_stocking, only: [:show, :edit, :update, :destroy]

  # GET /stockings
  # GET /stockings.json
  def index
    @stockings = Stocking.all.order(:purchase_date)
  end

  # GET /stockings/1
  # GET /stockings/1.json
  def show
  end

  # GET /stockings/new
  def new
    @stocking = Stocking.new
    3.times { @stocking.stocking_products.build }
  end

  # GET /stockings/1/edit
  def edit
    @stocking = Stocking.find(params[:id])
    t = 3 - @stocking.stocking_products.size.to_i
    t.times{ @stocking.stocking_products.build }
  end

  # POST /stockings
  # POST /stockings.json
  def create
    @stocking = Stocking.new(stocking_params)

    respond_to do |format|
      if @stocking.save
        format.html { redirect_to @stocking, notice: 'Stocking was successfully created.' }
        format.json { render :show, status: :created, location: @stocking }
      else
        format.html { render :new }
        format.json { render json: @stocking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stockings/1
  # PATCH/PUT /stockings/1.json
  def update
    respond_to do |format|
      if @stocking.update(update_stocking_params)
        format.html { redirect_to @stocking, notice: 'Stocking was successfully updated.' }
        format.json { render :show, status: :ok, location: @stocking }
      else
        format.html { render :edit }
        format.json { render json: @stocking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stockings/1
  # DELETE /stockings/1.json
  def destroy
    @stocking.destroy
    respond_to do |format|
      format.html { redirect_to stockings_url, notice: 'Stocking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_stocking
    @stocking = Stocking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def stocking_params
    params.require(:stocking).
      permit(:purchase_date, :product_type, :purchase_price, :shipping_cost,
        :use_points, :purchasing_cost, :payment_type, :purchase_place, :remarks,
        stocking_products_attributes: [:product_id, :color, :estimated_price, :stock]
      )
  end

  def update_stocking_params
    params.require(:stocking).
      permit(:purchase_date, :product_type, :purchase_price, :shipping_cost,
        :use_points, :purchasing_cost, :payment_type, :purchase_place, :remarks,
        stocking_products_attributes: [:product_id, :color, :estimated_price, :stock, :destroy, :id]
      )
  end
end
