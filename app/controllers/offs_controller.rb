class OffsController < ApplicationController
  before_action :set_off, only: [:show, :edit, :update, :destroy]

  # GET /offs
  # GET /offs.json
  def index
    @offs = Off.all
  end

  # GET /offs/1
  # GET /offs/1.json
  def show
  end

  # GET /offs/new
  def new
    @off = Off.new
  end

  # GET /offs/1/edit
  def edit
  end

  # POST /offs
  # POST /offs.json
  def create
    @off = Off.new(off_params)

    respond_to do |format|
      if @off.save
        format.html { redirect_to @off, notice: 'Off was successfully created.' }
        format.json { render :show, status: :created, location: @off }
      else
        format.html { render :new }
        format.json { render json: @off.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offs/1
  # PATCH/PUT /offs/1.json
  def update
    respond_to do |format|
      if @off.update(off_params)
        format.html { redirect_to @off, notice: 'Off was successfully updated.' }
        format.json { render :show, status: :ok, location: @off }
      else
        format.html { render :edit }
        format.json { render json: @off.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offs/1
  # DELETE /offs/1.json
  def destroy
    @off.destroy
    respond_to do |format|
      format.html { redirect_to offs_url, notice: 'Off was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_off
      @off = Off.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def off_params
      params.require(:off).permit(:start, :end, :user_id)
    end
end
