class V1::LocationsController < ApplicationController
  def create
    @location = V1::Location.new(location_params)
    if @location.save
      render json: { id: @location.id }, status: 202
    else
      render json: { message: t('locations.create.failed') }, status: 422
    end
  end

  def show
    @location = V1::Location.find(params[:id])
    if @location
      render json: { location: @location }.to_json
    else
      render json: { message: t('locations.find.failed') }, status: 404
    end
  end

  private

    def location_params
      params.require('location').permit(:client_uuid, :device_uuid, :timestamp, :latitude, :longitude,
                    :altitude, :vertical_accuracy, :horizontal_accuracy)
    end
end
