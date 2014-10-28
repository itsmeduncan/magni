require 'rails_helper'

describe ::V1::Location, type: :model do

  context 'initialize' do

    let(:attrs) { FactoryGirl.attributes_for(:v1_location) }

    [:client_uuid, :device_uuid, :timestamp, :latitude, :longitude, :altitude,
      :vertical_accuracy, :horizontal_accuracy].each do |attr|
      it "sets the :#{attr}" do
        expect(described_class.new(attrs.dup).send(attr)).to eq(attrs[attr])
      end
    end
  end

end
