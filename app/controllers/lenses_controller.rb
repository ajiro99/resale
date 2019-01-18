class LensesController < ApplicationController
  before_action :set_lens, only: [:edit, :update, :destroy]

  # GET /lenses
  # GET /lenses.json
  def index
    @lenses = Lense.all
  end

  # GET /lenses/new
  def new
    @lense = Lense.new
  end

  # GET /lenses/1/edit
  def edit
  end

  # POST /lenses
  # POST /lenses.json
  def create
    @lense = Lense.new(lense_params)

    respond_to do |format|
      if @lense.save
        format.html { redirect_to lenses_path, notice: 'Lense was successfully created.' }
        format.json { render :show, status: :created, location: @lense }
      else
        format.html { render :new }
        format.json { render json: @lense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lenses/1
  # PATCH/PUT /lenses/1.json
  def update
    respond_to do |format|
      if @lense.update(lense_params)
        format.html { redirect_to lenses_path, notice: 'Lense was successfully updated.' }
        format.json { render :show, status: :ok, location: @lense }
      else
        format.html { render :edit }
        format.json { render json: @lense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lenses/1
  # DELETE /lenses/1.json
  def destroy
    @lense.destroy
    respond_to do |format|
      format.html { redirect_to lenses_url, notice: 'Lense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lens
      @lense = Lense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lense_params
      params.require(:lense).permit(:type, :maker, :name, :color)
    end
end
