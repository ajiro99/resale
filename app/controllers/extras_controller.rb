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

    respond_to do |format|
      if @extra.save
        format.html { redirect_to extras_path, notice: 'Extra was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @extra.update(extra_params)
        format.html { redirect_to extras_path, notice: 'Extra was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @extra.destroy
    respond_to do |format|
      format.html { redirect_to extras_path, notice: 'Extra was successfully destroyed.' }
    end
  end

  private
  
  def set_extra
    @extra = Extra.find(params[:id])
  end

  def extra_params
    params.require(:extra).permit(:name, :price, :display, :remarks)
  end
end
