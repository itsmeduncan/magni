class V1::Location < ::Magni::V1::Entry

  attr_accessor :client_uuid, :device_uuid, :timestamp, :latitude, :longitude,
                :altitude, :vertical_accuracy, :horizontal_accuracy

  def initialize(data = {})
    super

    @client_uuid = data.delete(:client_uuid)
    @device_uuid = data.delete(:device_uuid)
    @timestamp   = data.delete(:timestamp)
    @latitude    = data.delete(:latitude)
    @longitude   = data.delete(:longitude)
    @altitude    = data.delete(:altitude)
    @vertical_accuracy   = data.delete(:vertical_accuracy)
    @horizontal_accuracy = data.delete(:horizontal_accuracy)
  end

  def to_hash
    super.merge({
      client_uuid: client_uuid,
      device_uuid: device_uuid,
      timestamp: timestamp,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      vertical_accuracy: vertical_accuracy,
      horizontal_accuracy: horizontal_accuracy
    })
  end
end
