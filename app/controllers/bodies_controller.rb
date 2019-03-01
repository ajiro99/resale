class BodiesController < ApplicationController
  before_action :set_body, only: %i(edit update destroy)

  def index
    @bodies = Body.all
  end

  def new
    @body = Body.new
  end

  def edit; end

  def create
    @body = Body.new(body_params)

    if @body.save
      redirect_to bodies_path, notice: 'Body was successfully created.'
    else
      render :new
    end
  end

  def update
    if @body.update(body_params)
      redirect_to bodies_path, notice: 'Body was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @body.destroy
    redirect_to bodies_url, notice: 'Body was successfully destroyed.'
  end

  private
  
  def set_body
    @body = Body.find(params[:id])
  end

  def body_params
    params.require(:body).permit(:type, :maker, :name, :remarks)
  end
end
