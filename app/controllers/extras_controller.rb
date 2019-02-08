class ExtrasController < ApplicationController
  before_action :set_extra, only: %i(edit update destroy)

  def index
    @extras = Extra.all
  end

  def new
    @extra = Extra.new
  end

  def edit; end

  def create
    @extra = Extra.new(extra_params)

    if @extra.save
      redirect_to extras_path, notice: 'Extra was successfully created.'
    else
      render :new
    end
  end

  def update
    if @extra.update(extra_params)
      redirect_to extras_path, notice: 'Extra was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @extra.destroy
    redirect_to extras_path, notice: 'Extra was successfully destroyed.'
  end

  private
  
  def set_extra
    @extra = Extra.find(params[:id])
  end

  def extra_params
    params.require(:extra).permit(:name, :price, :display, :remarks)
  end
end
