module Api
  module V1
    class HotelsController < ApplicationController
      def index
        destination_id = request.query_parameters[:destination]

        hotels = []
        if hotels_param = request.query_parameters[:hotels]
          hotel_ids = hotels_param.split(",").map(&:strip)
        end

        hotels = if hotel_ids&.any? && destination_id
          Hotel.where('id IN (?) OR destination_id = ?', hotel_ids, destination_id)
        elsif hotel_ids&.any?
          Hotel.where(id: hotel_ids)
        elsif destination_id
          Hotel.where(destination_id: destination_id)
        end

        render json: hotels
      end
    end
  end
end
