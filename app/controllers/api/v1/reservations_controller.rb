module Api
    module V1
      # Reservation controller
      class ReservationsController < ApplicationController
        before_action :authenticate_request!, only: %i[create update destroy]
        before_action :set_reservation, only: %i[update show destroy]
        def index
            @reservations = Reservation.all
          end
        
          def show
          end
        
          def new
            @reservation = Reservation.new
          end
        
          def create
            @reservation = Reservation.new(reservation_params)
            # @reservation = @current_user.reservations.new(reservation_params)
        
            if @reservation.save
              redirect_to @reservation, notice: "Reservation created successfully."
            else
              render :new
            end
          end
        
          def edit
          end
        
          def update
            if @reservation.update(reservation_params)
              redirect_to @reservation, notice: "Reservation updated successfully."
            else
              render :edit
            end
          end
        
          def destroy
            @reservation.destroy
        
            redirect_to reservations_path, notice: "Reservation deleted successfully."
          end
        
          private

          def set_reservation
            @reservation = Reservation.find(params[:id])
          end
        
          def reservation_params
            params.require(:reservation).permit(:city, :pick_up_date, :return_date, :user_id, :vespa_id)
          end
      end
    end
end
