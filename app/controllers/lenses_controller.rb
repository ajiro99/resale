class LensesController < ApplicationController
  before_action :set_lens, only: %i(edit update destroy)

  def index
    @lenses = Lense.all
  end

  def new
    @lense = Lense.new
  end

  def edit; end

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

  def destroy
    @lense.destroy
    respond_to do |format|
      format.html { redirect_to lenses_url, notice: 'Lense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_lens
    @lense = Lense.find(params[:id])
  end

  def lense_params
    params.require(:lense).permit(:type, :maker, :name)
  end
end
