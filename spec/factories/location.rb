FactoryGirl.define do
  factory :location, class: ::V1::Location do
    client_uuid SecureRandom.uuid
    device_uuid SecureRandom.uuid
    timestamp   { DateTime.now.to_s }
    latitude    "40.726111"
    longitude   "-74.005833"
    altitude    "25"
    vertical_accuracy "1.0"
    horizontal_accuracy "1.2"

    factory :v1_location do; end
  end

end
