module Api
  module V1
    class VespasController < ApplicationController
      # This controller handles Vespas in the API version 1.
      before_action :authenticate_request!, only: %i[index create update destroy]
      before_action :set_vespa, only: %i[update show destroy]

      # GET /vespas
      def index
        @vespas = @current_user.vespas
        render json: VespasRepresenter.new(@vespas).as_json
      end

      # POST /vespa
      def create
        @vespa = Vespa.new(vespa_params)
        @vespa.user = @current_user
        if @vespa.save
          render json: VespaRepresenter.new(@vespa).as_json, status: :created
        else
          render json: @vespa.errors, status: :unprocessable_entity
        end
      end

      # GET /vespas/:id
      def show
        render json: VespaRepresenter.new(@vespa).as_json
      end

      # PUT /vespas/:id
      def update
        @vespa.update(vespa_params)
        if @vespa.save
          render json: VespaRepresenter.new(@vespa).as_json, status: :created
        else
          render json: @vespa.errors, status: :unprocessable_entity
        end
      end

      # DELETE /vespas/:id
      def destroy
        @vespa.destroy
        head :no_content
      end

      private

      def vespa_params
        params.permit(:name, :description, :photo, :price, :model, :user_id)
      end

      def set_vespa
        @vespa = Vespa.find(params[:id])
      end
    end
  end
end
