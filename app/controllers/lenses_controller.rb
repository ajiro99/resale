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

    if @lense.save
      redirect_to lenses_path, notice: 'Lense was successfully created.'
      render :show, status: :created, location: @lense
    else
      render :new
      render json: @lense.errors, status: :unprocessable_entity
    end
  end

  def update
    if @lense.update(lense_params)
      redirect_to lenses_path, notice: 'Lense was successfully updated.'
      render :show, status: :ok, location: @lense
    else
      render :edit
      render json: @lense.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lense.destroy
    redirect_to lenses_url, notice: 'Lense was successfully destroyed.'
  end

  private
  
  def set_lens
    @lense = Lense.find(params[:id])
  end

  def lense_params
    params.require(:lense).permit(:type, :maker, :name)
  end
end
