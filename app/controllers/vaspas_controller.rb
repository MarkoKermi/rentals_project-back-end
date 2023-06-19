class VaspasController < ApplicationController
  before_action :set_vaspa, only: %i[ show update destroy ]

  # GET /vaspas
  def index
    @vaspas = Vaspa.all

    render json: @vaspas
  end

  # GET /vaspas/1
  def show
    render json: @vaspa
  end

  # POST /vaspas
  def create
    @vaspa = Vaspa.new(vaspa_params)

    if @vaspa.save
      render json: @vaspa, status: :created, location: @vaspa
    else
      render json: @vaspa.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vaspas/1
  def update
    if @vaspa.update(vaspa_params)
      render json: @vaspa
    else
      render json: @vaspa.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vaspas/1
  def destroy
    @vaspa.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaspa
      @vaspa = Vaspa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vaspa_params
      params.fetch(:vaspa, {})
    end
end
