class VespasController < ApplicationController
  module API
    module V1
      # This controller handles Vespas in the API version 1.
      class VespasController < ApplicationController
        before_action :authenticate_request!, only: %i[create update destroy]
        before_action :set_car, only: %i[update show destroy]
        
        # GET /vaspas
        def index
          @vaspas = Vaspa.all
          render json: VaspasRepresenter.new(@vaspas).as_json
        end

        # POST /vaspa
        def create
          @vaspa = current_user!.vaspas.create(vaspa_params)
          if @vaspa.save
            render json: VaspaRepresenter.new(@vaspa).as_json, status: :created
          else
            render json: @vaspa.errors, status: :unprocessable_entity
          end
        end

        # GET /vaspas/:id
        def show
          render json: VaspaRepresenter.new(@vaspa).as_json
        end

        # PUT /vaspas/:id
        def update
          @vaspa.update(vaspa_params)
          if @vaspa.save
            render json: VaspaRepresenter.new(@vaspa).as_json, status: :created
          else
            render json: @vaspa.errors, status: :unprocessable_entity
          end
        end

        # DELETE /vaspas/:id
        def destroy
          @vaspa.destroy

        # GET /vespas
        def index
          @vespas = Vespa.all
          render json: VespasRepresenter.new(@vespas).as_json
        end

        # POST /vespa
        def create
          @vespa = current_user!.vespas.create(vespa_params)
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

        def vaspa_params
          params.permit(:name, :description, :photo, :price, :model, :user_id)
        end

        def set_vaspa
          @vaspa = Vaspa.find(params[:id])

        def vespa_params
          params.permit(:name, :description, :photo, :price, :model, :user_id)
        end

        def set_vespa
          @vespa = Vespa.find(params[:id])
        end
      end
    end
  end
end
