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

    respond_to do |format|
      if @body.save
        format.html { redirect_to bodies_path, notice: 'Body was successfully created.' }
        format.json { render :show, status: :created, location: @body }
      else
        format.html { render :new }
        format.json { render json: @body.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @body.update(body_params)
        format.html { redirect_to bodies_path, notice: 'Body was successfully updated.' }
        format.json { render :show, status: :ok, location: @body }
      else
        format.html { render :edit }
        format.json { render json: @body.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @body.destroy
    respond_to do |format|
      format.html { redirect_to bodies_url, notice: 'Body was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_body
    @body = Body.find(params[:id])
  end

  def body_params
    params.require(:body).permit(:type, :maker, :name)
  end
end
